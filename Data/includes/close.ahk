/**
 * Maps Ctrl + W to Alt + F4 in some applications
 *
 * For the rest, it sends back Ctrl + W for default functionality
 */
Close:
   WinGetTitle, Title, A
   WinGetClass, Class, A

   List_Classes =
   (
      Notepad, HH Parent, MyUninstaller100, Everything, Photo_Lightweight_Viewer, FM,
      µTorrent4823DF041B09, WMPlayerApp, WindowsForms10.Window.20008.app.0.232467a,
      WindowsForms10.Window.8.app.0.3e799b_r11_ad1
   )

   List_Titles =
   (
      Foxit PhantomPDF
   )

   ; Foxit closes only when no tabs exist
   If InStr(List_Classes, Class) or InStr(List_Titles, Title)
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
