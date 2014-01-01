/**
 * Run Cmder in current folder.
 *
 * Would Override Console2
 */

RunCmder:
   CmderPath := "F:\[Softwares]\[PowerPack]\Cmder"

   If WinActive("ahk_class PX_WINDOW_CLASS")
   {
      FilePath := GetPathFromSublime()
      SplitPath, FilePath, , Path ; The Directory
   }
   Else
      Path := GetCurrentFolderPath()

   Path := (Path = "") ? "D:\I, Coder\@ GitHub" : Path

   ; This environment variable is used by "init.bat" of the Cmder Project
   EnvSet, CMDER_ROOT, %CmderPath%

   ; Copied from "Cmder.bat"
   Run, %CmderPath%/vendor/conemu-maximus5/ConEmu.exe /Icon "%CmderPath%\icons\cmder.ico" /Dir "%Path%" /Title Cmder /LoadCfgFile "%CmderPath%\config\ConEmu.xml"
Return
