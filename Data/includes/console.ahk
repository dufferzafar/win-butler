/**
 * Opens command prompt in the current folder.
 */

RunCmder:
   ; Todo: Settings - Get the path of Cmder directory
   CmderPath := "F:\PowerPack\Cmder"

   If WinActive("ahk_class PX_WINDOW_CLASS")
   {
      FilePath := GetPathFromSublime()
      SplitPath, FilePath, , Path ; The Directory
   }
   Else If WinActive("ahk_class ThunderRT6FormDC")
      Path := GetPathFromXYplorer()
   Else
      Path := GetCurrentFolderPath()

   Path := (Path = "") ? "D:\GitHub" : Path

   ; This environment variable is used by Cmder Project
   EnvSet, CMDER_ROOT, %CmderPath%

   ; Launch ConEmu
   Run, %CmderPath%/vendor/conemu/ConEmu64.exe /Single /Dir "%Path%" /Icon "%CmderPath%\Cmder.ico" /LoadCfgFile "%CmderPath%\config\ConEmu.xml"
Return

RunBash:
   CmderPath := "F:\PowerPack\Cmder"

   If WinActive("ahk_class PX_WINDOW_CLASS")
   {
      FilePath := GetPathFromSublime()
      SplitPath, FilePath, , Path ; The Directory
   }
   Else If WinActive("ahk_class ThunderRT6FormDC")
      Path := GetPathFromXYplorer()
   Else
      Path := GetCurrentFolderPath()

   Path := (Path = "") ? "D:\GitHub" : Path

   EnvSet, CMDER_ROOT, %CmderPath%

   ; Launch ConEmu
   Run, %CmderPath%/vendor/conemu/ConEmu64.exe /Single /Dir "%Path%" /Icon "%CmderPath%\Cmder.ico" /LoadCfgFile "%CmderPath%\config\ConEmu.xml" /cmd %CmderPath%\vendor\msysgit\bin\sh.exe -l -i
Return
