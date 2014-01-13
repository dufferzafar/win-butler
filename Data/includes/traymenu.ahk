Build_TrayMenu:
   ; Modify the Menu
   Menu, Tray, NoStandard
   Menu, Tray, Tip, Windows Butler ; %Version%

   Menu, SS_Menu, Add, % "Ratio: 25%", SS_Menu_Handler
   Menu, SS_Menu, Add, % "Ratio: 50%", SS_Menu_Handler
   Menu, SS_Menu, Add, % "Ratio: 75%", SS_Menu_Handler
   Menu, SS_Menu, Add, % "Ratio: 100%", SS_Menu_Handler

   Menu, BB_Menu, Add, % "Pause Backups", BB_ToggleBackup
   Menu, BB_Menu, Add, % "Open Backup Directory", BB_OpenBackups

   Menu, Tray, Add, Screenshot, :SS_Menu
   Menu, Tray, Add
   Menu, Tray, Add, Backup Buddy, :BB_Menu
   Menu, Tray, Add
   Menu, Tray, Add, &About, ShowGui
   Menu, Tray, Add
   ; Todo: HIGH! - Reload Menu
   Menu, Tray, Add, &Suspend, SuspendMe
   Menu, Tray, Add, &Exit, CloseMe

   Menu, Tray, Default, &About

   Menu, SS_Menu, Check, % "Ratio: 100%"
   Ratio_LastMenuItem := "Ratio: 100%"
Return

Show_TrayMenu:
   ; Set the icon
   Menu, Tray, Icon, Data\icons\Butler.ico

   ;Else show default icon
   Menu, Tray, Icon

   ; Let the user know we have started
   TrayTip, Windows Butler %Version%,
   (

   Hey! I'm right here...

   Consult readme for usage instructions.
   ), , 1
   SetTimer, RemoveTrayTip, 3000
Return

SS_Menu_Handler:
   If RegExMatch(A_ThisMenuItem, "^Ratio: (\d+)%$", Ratio)
   {
      ScreenShot_Size := (Ratio1 / 100)
      Menu, SS_Menu, UnCheck, % Ratio_LastMenuItem
      Menu, SS_Menu, Check, % A_ThisMenuItem
      Ratio_LastMenuItem := A_ThisMenuItem
   }
Return

BB_ToggleBackup:
   If (BB_Toggle)
   {
      BB_Toggle := 0
      ; Todo: Correct Menu
      Menu, Tray, Rename, Pause Backups, Resume Backups
      SetTimer, BB_Backup, Off
   }
   Else
   {
      BB_Toggle := 1
      Menu, Tray, Rename, Resume Backups, Pause Backups
      SetTimer, BB_Backup, % Period * 60 * 1000
   }
Return

BB_OpenBackups:
   Run, %Destination%
Return

SuspendMe:
   Suspend, Toggle

   Menu, Tray, ToggleCheck, &Suspend

   If (A_IsSuspended = 1)
      Menu, Tray, Icon, Data\icons\butler-suspended.ico, , 1
   Else
      Menu, Tray, Icon, Data\icons\butler.ico, , 1
Return
