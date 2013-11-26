/**
 * Open the selected file in sublime
 *
 * I am too lazy to even right-click :)
 */
OpenInSublime:
	files := GetSelectedText()
	sublParams =

	StringSplit, filesArray, files, `n

	Loop, %filesArray0%
	{
		thisFile := filesArray%A_Index%
		StringReplace, thisFile, thisFile, `r, , all

		; Leave out the directories
		If(attr := FileExist(thisFile))
			If !InStr(attr, "D")
			{
				filePath = "%thisFile%"
				sublParams .= " " . filePath
			}
	}

	If (sublParams)
		Run, subl.exe -n %sublParams%, , Max
Return

/**
 * Run the currently open file in Sublime Text
 *
 * Adjusts PHP/HTML files to take localhost into account
 *
 * Todo: Handle Untitled Files
 */
RunFromSublime:
	Send ^s
	Sleep 100
	WinGetTitle, wTitle, ahk_class PX_WINDOW_CLASS
	; wTitle := "D:\I, Coder\@ GitHub\win-butler\Test.ahk (WinButler) - Sublime Text"

	StringTrimRight, File, wTitle, 15

	If FileExist(File)
	{
		ScriptPath := File
	}
	Else
	{
		pos := InStr(wTitle, "(", False, 0)
		ScriptPath := SubStr(wTitle, 1, pos-1)
	}

	If FileExist(ScriptPath)
	{
		; Use the default handler for scripts
		If InStr(wTitle, ".lua") or InStr(wTitle, ".ahk") or InStr(wTitle, ".py")
		{
			SplitPath, wTitle,,workingDir
			Run, %ScriptPath%, %workingDir%
		}
		; If this is an octopress post. Preview.
		Else If InStr(wTitle, ".markdown")
		{
			Run, % "Chrome.exe http://localhost:4000/blog/"
		}
		Else If InStr(wTitle, ".php") or InStr(wTitle, ".html")
		{
			; If the file is in any other folder, the line below won't have any effect
			StringReplace, NewScriptPath, ScriptPath,% "C:\xampp\htdocs\", % "http://localhost/"

			Run, chrome.exe "%NewScriptPath%"
		}
		Else
			Run, %ScriptPath%
	}
/*
	Else ; If the file still does not exist - it must be "Untitled"
	{
		; Save and Run as Temporary AHK.
		StringTrimRight, ScriptPath, ScriptPath, 3

		FileName = TempAHKScript-%A_Hour%-%A_Min%-%A_Sec%.ahk
		FileAppend, %selection%, %A_Temp%\%FileName%
		Run, %Path%\%FileName%, %Path%
	}
*/
Return
