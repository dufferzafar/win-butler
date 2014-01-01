Close:
   WinGetActiveTitle, Title

   ; Todo: Global Ctrl+W List
   If (InStr(Title, "Notepad") or InStr(Title, "MyUninstaller"))
   {
      Send, !{F4}
   }
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
