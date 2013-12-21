Setup_BackupBuddy:

	7ZipPath := "Data\7z.exe"

	Sources =
	( LTrim Join|
	D:\I, Coder\@ GitHub\backup-buddy
	D:\I, Coder\@ GitHub\win-butler
	)

	Destination := "F:\Backups"
	FileCreateDir, %Destination%

	Password := ""
	Period := 15
	BackupsToKeep := 5

	Method := "-mx0"
	Yes := "-y"

	If (Password != "")
		PSwitch := "-p" . Password . " -mhe"
	Else
		PSwitch := ""

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

	SetTimer, BB_Backup, % Period * 60 * 1000

Return	 ; End of Auto Execute Section

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
TrayTip, Windows Butler,
(

Backup Done!
)
SetTimer, RemoveTrayTip, 2500

Return

/**
 * Returns the number of files of the specified typ
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
