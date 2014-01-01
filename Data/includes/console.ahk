/**
 * Run Console/CMD
 *
 * Run console (or command prompt) in the current folder.
 */
RunConsole:
   Path := GetCurrentFolderPath()
   Path := (Path = "") ? "C:\" : Path

   ; Todo: Path from Settings
   If FileExist("Data\console2\console.exe")
      Run, Data\console2\console.exe -d "%Path%"
   Else
      Run, cmd /K cd /D "%Path%"
Return

RunGitShell:
   GitShell := "C:\Users\dufferzafar\AppData\Local\GitHub\PortableGit_fed20eba68b3e238e49a47cdfed0a45783d93651\bin\sh.exe"

   If WinActive("ahk_class PX_WINDOW_CLASS")
   {
      WinGetTitle, wTitle, ahk_class PX_WINDOW_CLASS
      StringTrimRight, File, wTitle, 15

      If FileExist(File)
         ScriptPath := File
      Else
      {
         pos := InStr(wTitle, "(", False, 0)
         ScriptPath := SubStr(wTitle, 1, pos-1)
      }
      SplitPath, ScriptPath, , Path
   }
   Else
      Path := GetCurrentFolderPath()

   Path := (Path = "") ? "D:\I, Coder\@ GitHub" : Path

   Run, %GitShell% --login -i, %Path%, Max
Return

CloseCMD:
   WinKill, A
Return

ScrollUp:
   ControlGetFocus, control, A
   SendMessage, 0x115, 2, 0, %control%, A ; WM_VSCROLL = 0x115 | SB_LINEUP = 0
Return

ScrollDown:
   ControlGetFocus, control, A
   SendMessage, 0x115, 3, 0, %control%, A ; WM_VSCROLL = 0x115 | SB_LINEDOWN = 0
Return

ScrollTop:
   ControlGetFocus, control, A
   SendMessage, 0x115, 6, 0, %control%, A ; WM_VSCROLL = 0x115 | SB_TOP = 6
Return

ScrollBottom:
   ControlGetFocus, control, A
   SendMessage, 0x115, 7, 0, %control%, A ; WM_VSCROLL = 0x115 | SB_BOTTOM = 7
Return

/**
 * Used to send clipboard data to command prompt
 */
PasteClipboard:
   SendRaw %clipboard%
Return
