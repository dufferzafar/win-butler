
/**
 * Maps Ctrl + W to Alt + F4 in some applications
 *
 * For the rest, it sends back Ctrl + W for default functionality
 */
Close:
   WinGetClass, Class, A

   ; Todo: Global Ctrl+W List
   WhiteList := "Notepad, HH Parent, MyUninstaller100, Everything"

   If InStr(WhiteList, Class)
      Send, !{F4}
   Else
      Send, ^w
Return

; Todo: Add support to kill not responding processes...
KillWindow:
   ; WinKill, % "ahk_id " WinExist("A")
   WinGet, Process, ProcessName, A
   Run, % comspec " /c taskkill /f /im " Process, Hide
   ; Msgbox, % Process
Return
