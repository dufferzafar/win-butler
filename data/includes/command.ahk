/**
 * Run CMD
 *
 * Run command prompt in the current folder.
 *
 * Todo: Run even if explorer isn't open. C:\
 * Todo: Run Console2 instead of normal command prompt
 */
RunCMD:
	full_path := GetCurrentFolder7()
	IfInString full_path, \
	{
		Run, cmd /K cd /D "%full_path%"
		; Run, Data\console2\console.exe -d "%full_path%"
	}
	else ;If path is not valid
	{
		Run, cmd /K cd /D "C:\ "
	}
Return

CloseCMD:
	WinKill, A
Return

/**
 * Used to send clipboard data to command prompt
 */
PasteClipboard:
	SendRaw %clipboard%
Return