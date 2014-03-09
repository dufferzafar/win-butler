/**
 * Opens command prompt in the current folder.
 */

RunCmder:
   CmderPath := "E:\PowerPack\Cmder"
   EnvSet, CMDER_ROOT, %CmderPath%

   Path := GetPath()
   Run, %CmderPath%/vendor/conemu/ConEmu64.exe /Single /Dir "%Path%" /Title Cmder /Icon "%CmderPath%\Cmder.ico" /LoadCfgFile "%CmderPath%\config\ConEmu.xml"
Return

RunBash:
   CmderPath := "E:\PowerPack\Cmder"
   EnvSet, CMDER_ROOT, %CmderPath%

   Path := GetPath()
   Run, %CmderPath%/vendor/conemu/ConEmu64.exe /Single /Dir "%Path%" /Title Cmder /Icon "%CmderPath%\Cmder.ico" /LoadCfgFile "%CmderPath%\config\ConEmu.xml" /cmd %CmderPath%\vendor\msysgit\bin\sh.exe -l -i
Return

GetPath() {
   If WinActive("ahk_class PX_WINDOW_CLASS")
   {
      FilePath := GetPathFromSublime()
      SplitPath, FilePath, , Path ; The Directory
   }
   Else
      Path := GetCurrentFolderPath()

   Path := (Path = "") ? "E:\dufferZafar\@ Github" : Path

   Return Path
}
