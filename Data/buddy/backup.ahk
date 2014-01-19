; Todo: All settings in a new tab of gui
; Bug: Pause Backups Doesn't work
; Todo: Backup Log, Last backup at:
Setup_BackupBuddy:
   7ZipPath := "Data\Buddy\7z.exe"

   Sources =
   ( LTrim Join|
   D:\I, Coder\@ GitHub\win-butler
   D:\I, Coder\@ GitHub\dufferzafar.github.com
   D:\I, Coder\@ GitHub\personal-analytics
   D:\I, Coder\@ GitHub\Todo
   C:\xampp\htdocs\cryptex
   )

   Destination := "F:\Backups"
   FileCreateDir, %Destination%

   Period := 30 ; In Minutes
   BackupsToKeep := 3

   Password := "" ; Set Password Here
   If (Password != "")
      PSwitch := "-p" . Password . " -mhe"
   Else
      PSwitch := ""

   Method := "-mx0"
   Yes := "-y"

   ; Used to detect if automated backup is on
   BB_Toggle := 1

   ; There should be atleast one backup
   If (BackupsToKeep < 1)
      BackupsToKeep := 1
   Else ; Make sure it isn't a fraction
      BackupsToKeep := Floor(BackupsToKeep)

   ; ExcludeFiles := "-xr!*.ahk"
   ; ExcludeFolders := "-xr!Help"
   ; Params = %Destination%\%DestDir%\%FileName%.7z "%Source%" %Yes% %Method% %ExcludeFiles% %ExcludeFolders%
   ; FileDelete, %Destination%\%DestDir%\*.7z ; delete previous ones

   SetTimer, BB_Backup, % Period * 60 * 1000

Return    ; End of Auto Execute Section

BB_Backup:
   ; SetTimer, SwapIcon, 500

   Loop, Parse, Sources, |
   {
      SplitPath, A_LoopField, FolderName
      DestDir := Destination "\" FolderName

      If FileExist(A_LoopField)
      {
         FileName = %A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

         Params = %DestDir%\%FileName%.7z "%A_LoopField%" %Yes% %Method% %PSwitch%
         ; Msgbox, Params

         RunWait, % 7ZipPath . " a " . Params, %A_ScriptDir% , Hide

         Files := CountFiles(DestDir, "7z")
         ; Msgbox, % Files

         ; Delete Older Files
         If ( Files > BackupsToKeep)
         {
            Count := Files - BackupsToKeep
            Loop, %DestDir%\*.7z
            {
               FileDelete, %A_LoopFileFullPath%
               Count--
               If (Count == 0)
                  Break
            }
         }
      }
   }
TrayTip, Windows Butler %Version%,
(

Backup Done!
), , 1
SetTimer, RemoveTrayTip, 2000

Return

/**
 * Returns the number of files of the specified type
 *  present in a the given folder
 */
CountFiles(Dir, Ext)
{
   Count := 0
   Loop, %Dir%\*.%Ext%
   {
      ; Msgbox, % A_LoopFileName
      Count++
   }
   Return Count
}
