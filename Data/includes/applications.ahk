StartupDelay:

   AppList =
   ( LTrim Join|
      E:\Powerpack\Launchy\Launchy.exe
      C:\Program Files\NetWorx\networx.exe /auto
      E:\Powerpack\Manic Time\ManicTime.exe /minimized /name:
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
      Run, E:\Powerpack\Manic Time\ManicTime.exe

   If !FindProc("networx.exe")
      Run, C:\Program Files\NetWorx\networx.exe
Return

FindProc(p) {
   Process, Exist, % p
   Return, ErrorLevel
}
