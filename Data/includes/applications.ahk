StartupDelay:
   AppList =
   ( LTrim Join|
      C:\Users\dufferzafar\AppData\Local\FluxSoftware\Flux\flux.exe /noshow
      C:\Program Files\NetWorx\networx.exe /auto
      F:\Powerpack\ShareX\ShareX.exe
      F:\PowerPack\Manic Time\ManicTime.exe /minimized /name:
   )

   ; Run Listed Apps
   Loop, Parse, AppList, |
   {
      Sleep, 30 * 1000

      SplitPath, A_LoopField, OutFileName
      RegExMatch(OutFileName, "(.*.exe)", JustExe)

      ; If process is not already running
      ; Todo: Whatif the files don't exist?
      If !FindProc(JustExe) ; And FileExist(A_LoopField)
         Run, % A_LoopField
   }
Return

AlwaysRunning:
   If !FindProc("ManicTime.exe") or !FindProc("ManicTimeClient.exe")
      Run, F:\PowerPack\Manic Time\ManicTime.exe

   If !FindProc("networx.exe")
      Run, C:\Program Files\NetWorx\networx.exe
Return

Jrnl:
  ; Todo: Settings - Get the path of Cmder directory
   CmderPath := "F:\PowerPack\Cmder"

   ; This environment variable is used by Cmder Project
   EnvSet, CMDER_ROOT, %CmderPath%

   ; Launch Jrnl (Vim) in ConEmu
   Run, %CmderPath%/vendor/conemu/ConEmu64.exe /Single /Icon "%CmderPath%\Cmder.ico" /LoadCfgFile "%CmderPath%\config\ConEmu.xml" /cmd F:\Powerpack\Cmder\vendor\jrnl\env\Scripts\jrnl.exe
Return

ShowShareX:
   If !FindProc("sharex.exe")
      Run, F:\Powerpack\ShareX\ShareX.exe

   DetectHiddenWindows, On
   WinShow, ahk_class WindowsForms10.Window.8.app.0.3e799b_r11_ad1
   WinActivate, ahk_class WindowsForms10.Window.8.app.0.3e799b_r11_ad1
Return

FindProc(p) {
   Process, Exist, % p
   Return, ErrorLevel
}
