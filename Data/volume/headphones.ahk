/**
 * This script wouldn't have been possible without
 * Geekdude from #ahk. https://github.com/G33kDude
 *
 * He wrote 99% of the code. I've just added some
 * annotations.
 */

#Include, VA.inc.ahk

SetupHeadphones:
    /**
     * Based on the assumption that the headphones are
     * not connected when the script starts.
     */
    Connected := False
    Gosub, RunChildProcess
Return

RunChildProcess:
    DetectHiddenWindows, On
    Dyna =
    (
        #Persistent
        ; #NoTrayIcon
        ; #Include Data\volume\VA.inc.ahk
        #Include VA.inc.ahk
        CLSID_MMDeviceEnumerator := "{BCDE0395-E52F-467C-8E3D-C4579291692E}"
        IID_IMMDeviceEnumerator := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
        if !(deviceEnumerator := ComObjCreate(CLSID_MMDeviceEnumerator, IID_IMMDeviceEnumerator))
            ExitApp
        OnExit, ExitSub
        Print("")
        VA_IMMDeviceEnumerator_RegisterEndpointNotificationCallback(deviceEnumerator,RegisterCallback("Callback"))
        Return
        ExitSub:
            ObjRelease(DeviceEnumerator)
        ExitApp
        Callback(p*) {
            Return
        }
        Print(x) {
            Static c:=FileOpen("CONOUT$", ("rw",DllCall("AllocConsole")))
            c.Write(x), c.__Handle
        }
    )

    /**
     * The above code is run dynamically.
     *
     * It does NOT work, and crashes as soon as headphones are
     * connected or disconnected, but as the crash happens every
     * single time...
     */
    PID := Dyna_Run(Dyna)

    Gosub, WaitForHeadphones
Return

/**
 * ...we wait for it.
 *
 * If the above script crashed, we know, that headphones
 * must've been connected or disconnected.
 */
WaitForHeadphones:
    ; Depends on the AHK version you're using
    WinWait, AutoHotkey Unicode 64-bit ahk_class #32770
    WinClose

    If (!Connected)
        Gosub, Connected
    Else
        Gosub, Disconnected
    SetTimer, RemoveTrayTip, 2000

    ; Start watching for another event now.
    Gosub, RunChildProcess
Return

/**
 * This gets executed when the headphones are connected.
 *
 * You can do stuff like, Launch your favorite media player etc.
 * I use it to protect my ear drums :)
 */
Connected:
    ; Reduce volume
    VA_SetMasterVolume(10)
    Connected := True

TrayTip, Windows Butler %Version%,
(

Headphones Connected. Volume Reduced.
), , 1
Return

Disconnected:
    ; Reset volume
    VA_SetMasterVolume(100)
    Connected := False

TrayTip, Windows Butler %Version%,
(

Headphones disconnected. Volume Maxed.
), , 1
Return

/**
 * If you know what is happening here, please let me know.
 */
Dyna_Run(s, pn:="", pr:=""){ ; s=Script,pn=PipeName,n:=,pr=Parameters,p1+p2=hPipes,P=PID
    Static AhkPath:="""" A_AhkPath """" (A_IsCompiled||(A_IsDll&&DllCall(A_AhkPath "\ahkgetvar","Str","A_IsCompiled"))?" /E":"") " """
    If (-1=p1 := DllCall("CreateNamedPipe","str",pf:="\\.\pipe\" (pn!=""?pn:"AHK" A_TickCount),"uint",2,"uint",0,"uint",255,"uint",0,"uint",0,"Ptr",0,"Ptr",0))
        || (-1=p2 := DllCall("CreateNamedPipe","str",pf,"uint",2,"uint",0,"uint",255,"uint",0,"uint",0,"Ptr",0,"Ptr",0))
        Return 0
    Run, % AhkPath pf """ " pr,,UseErrorLevel HIDE, P
    If ErrorLevel
        return 0,DllCall("CloseHandle","Ptr",p1),DllCall("CloseHandle","Ptr",p2)
    DllCall("ConnectNamedPipe","Ptr",p1,"Ptr",0),DllCall("CloseHandle","Ptr",p1),DllCall("ConnectNamedPipe","Ptr",p2,"Ptr",0)
    if !DllCall("WriteFile","Ptr",p2,"Wstr",s:=(A_IsUnicode?chr(0xfeff):"﻿") s,"UInt",StrLen(s)*(A_IsUnicode ? 2 : 1)+(A_IsUnicode?4:6),"uint*",0,"Ptr",0)
    P:=0
    DllCall("CloseHandle","Ptr",p2)
    Return P
}

RemoveTrayTip:
    SetTimer, RemoveTrayTip, Off
    TrayTip
Return
