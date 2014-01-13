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
