StartupDelay:

   AppList =
   ( LTrim Join|
      C:\Users\dufferzafar\AppData\Local\FluxSoftware\Flux\flux.exe /noshow
      C:\Program Files\NetWorx\networx.exe /auto
      F:\[Softwares]\[PowerPack]\Manic Time\ManicTime.exe /minimized /name:
   )

      ; F:\[Softwares]\[PowerPack]\Listary\Listary.exe
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
      Run, F:\[Softwares]\[PowerPack]\Manic Time\ManicTime.exe

   If !FindProc("networx.exe")
      Run, C:\Program Files\NetWorx\networx.exe
Return

FindProc(p) {
   Process, Exist, % p
   Return, ErrorLevel
}
