/**
 * Run Cmder in current folder.
 *
 * Would Override Console2
 */

RunCmder:
   CmderPath := "F:\[Softwares]\[PowerPack]\Cmder"

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

   ; This environment variable is used by "init.bat" of the Cmder Project
   EnvSet, CMDER_ROOT, %CmderPath%

   ; Copied from "Cmder.bat"
   Run, %CmderPath%/vendor/conemu-maximus5/ConEmu.exe /Icon "%CmderPath%\icons\cmder.ico" /Dir "%Path%" /Title Cmder /LoadCfgFile "%CmderPath%\config\ConEmu.xml"
Return

/**
 * Run the git shell (sh.exe) in the current folder.
 */

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
