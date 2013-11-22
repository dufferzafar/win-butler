Debug(Section){
   static id,pSFW,pSW,bkpSFW,bkpSW
   If !id
   {
      d:=A_DetectHiddenWindows
      DetectHiddenWindows,On
      Process,Exist
      ControlGet,id,Hwnd,,Edit1,ahk_class AutoHotkey ahk_pid %ErrorLevel%
      DetectHiddenWindows,%d%
      astr:=(A_IsUnicode?"astr":"str"),ptr=(A_PtrSize=8?"ptr":"uint"),hmod=DllCall("GetModuleHandle","str","user32.dll"),pSFW=DllCall("GetProcAddress",ptr,hmod,astr,"SetForegroundWindow"),pSW=DllCall("GetProcAddress",ptr,hmod,astr,"ShowWindow")
      ,DllCall("VirtualProtect",ptr,pSFW,ptr,8,"uint",0x40,"uint*",0),DllCall("VirtualProtect",ptr,pSW,ptr,8,"uint",0x40,"uint*",0),bkpSFW=NumGet(pSFW+0,0,"int64"),bkpSW=NumGet(pSW+0,0,"int64")
   }(A_PtrSize=8?(NumPut(0x0000C300000001B8,pSFW+0,0,"int64"),NumPut(0x0000C300000001B8,pSW+0,0,"int64")):(NumPut(0x0004C200000001B8,pSFW+0,0,"int64"),NumPut(0x0008C200000001B8,pSW+0,0,"int64")))
   If(Section="Vars")
      ListVars
   else If(Section="Lines")
      ListLines
   else If(Section="Hotkeys")
      ListHotkeys
   else If(Section="KeyHistory")
      KeyHistory
   else return 0
   NumPut(bkpSFW,pSFW+0,0,"int64"),NumPut(bkpSW,pSW+0,0,"int64")
   ControlGetText,O,,ahk_id %id%
return O
}
