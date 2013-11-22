/**
 * Run CMD
 *
 * Run command prompt in the current folder.
 *
 */
RunConsole:
	full_path := GetCurrentFolder7()

	IfInString full_path, \
	{
		; Run, cmd /K cd /D "%full_path%"
		Run, Data\console2\console.exe -d "%full_path%"
	}
	Else ;If path is not valid
	{
		; Run, cmd /K cd /D "C:\ "
		Run, Data\console2\console.exe -d "C:\"
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
