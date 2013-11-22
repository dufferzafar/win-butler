/**
 * Global Variables
 *
 * Edit only if you are sure enough.
 */

; The path to 7Zip executable. Make sure 7z.dll is present too.
7ZipPath := "Data\7z.exe"

/**
 * Folders to backup
 *
 * Add paths of the folders that you want to backup.
 * Remove the ones already present.
 */
Sources =
( LTrim Join|
D:\I, Coder\@ GitHub\backup-buddy
D:\I, Coder\@ GitHub\win-butler
)

/**
 * The folder where the backups will be saved
 *
 * A new folder will be created for each of your source
 * folders in this directory and the backups will be saved
 * there. So this serves as a root of all your backups.
 */

Destination := "F:\Backups"

; A password if you want the backups to be protected.
Password := ""

; Time in minutes when the backups will be performed
Period := 15

; Number of backups to keep
BackupsToKeep := 5

; ######################## Script Begins ########################

OnExit, CloseMe

; Modify the Menu
; Menu, Tray, NoStandard
; Menu, Tray, Tip, %Name% ; %Version%

; Menu, Tray, Add, &Pause Backups, PlayPauseBackup
; Menu, Tray, Add
; Menu, Tray, Add, &Open Backup Directory, OpenBackups
; Menu, Tray, Add
; Menu, Tray, Add, &Exit, CloseMe

; Set the icon if it exist
; IfExist, %A_ScriptDir%\Data\White.ico
; 	Menu, Tray, Icon, %A_ScriptDir%\Data\White.ico

; Menu, Tray, Icon	;Else show default icon

; Create the root if it doesn't exist
FileCreateDir, %Destination%

; Compression method to use. See 7Zip help.
Method := "-mx0"

; Assume yes on all stuff
Yes := "-y"

; If Password is provided - use it.
If (Password != "")
	PSwitch := "-p" . Password . " -mhe"
Else
	PSwitch := ""

; Used by PlayPauseBackup to detect if the backups are being performed
PlayPause := 1

; There should be atleast one backup
If (BackupsToKeep < 1)
	BackupsToKeep := 1
Else ; Make sure it isn't a fraction
	BackupsToKeep := Floor(BackupsToKeep)

; ExcludeFiles := "-xr!*.ahk"
; ExcludeFolders := "-xr!Help"
; Params = %Destination%\%DestDir%\%FileName%.7z "%Source%" %Yes% %Method% %ExcludeFiles% %ExcludeFolders%
; FileDelete, %Destination%\%DestDir%\*.7z ; delete previous ones

SetTimer, Backup, % Period * 60 * 1000

Return	 ; End of Auto Execute Section

Backup:
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
TrayTip, %Name% %Version%,
(

Backups Done!
)
SetTimer, RemoveTrayTip, 2500
Return

; ######################## Misc. Stuff ########################

/**
 * Miscellaneous Routines
 */

/**
 * Returns the number of files of the specified typ
 *  present in a the given folder
 *
 * @param String Dir [The directory]
 * @param String Ext [The Filetype]
 * @Return Number Count [The number of files]
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

PlayPauseBackup:
	If (PlayPause)
	{
		PlayPause := 0
		Menu, Tray, Rename, &Pause Backups, &Resume Backups
		SetTimer, Backup, Off
	}
	Else
	{
		PlayPause := 1
		Menu, Tray, Rename, &Resume Backups, &Pause Backups
		SetTimer, Backup, % Period * 60 * 1000
	}
Return

OpenBackups:
	Run, %Destination%
Return

RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
Return

RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off
	TrayTip
Return

SuspendMe:
	Suspend, Toggle
Return

CloseMe:
	ExitApp
