/**
 * Launches the currently opened file's folder
 */
FolderFromSublime:
   FilePath := GetPathFromSublime()
   SplitPath, FilePath, , Path ; The Directory
   Run, % Path, , Max
Return


/**
 * Extracts the current file's path from sublime text.
 */
GetPathFromSublime()
{
   WinGetTitle, wTitle, ahk_class PX_WINDOW_CLASS
   ; wTitle := "D:\I, Coder\@ GitHub\win-butler\Test.ahk (WinButler) - Sublime Text"

   StringTrimRight, File, wTitle, 15

   If FileExist(File)
      ScriptPath := File
   Else
   {
      pos := InStr(wTitle, "(", False, 0)
      ScriptPath := SubStr(wTitle, 1, pos-1)
   }

   Return %ScriptPath%
}

/**
 * Open the selected file in sublime
 *
 * Todo: GetSelectedFiles via SFV
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

   If FileExist(ScriptPath := GetPathFromSublime())
   {
      ; Use the default handler for scripts
      If InStr(ScriptPath, ".lua") or InStr(ScriptPath, ".ahk") or InStr(ScriptPath, ".py")
      {
         SplitPath, ScriptPath,,workingDir
         Run, %ScriptPath%, %workingDir%
      }
      ; An octopress post - Preview via blog.
      Else If InStr(ScriptPath, ".markdown")
      {
         Run, % "firefox.exe http://localhost:4000/blog/"
      }
      ; Other Markdown - Preview via Sublime's Plugin.
      Else If InStr(ScriptPath, ".md")
      {
         Send, !m
      }
      Else If InStr(ScriptPath, ".php") or InStr(ScriptPath, ".html")
      {
         ; If the file is in any other folder, the line below won't have any effect
         StringReplace, NewScriptPath, ScriptPath,% "C:\xampp\htdocs\", % "localhost\"
         Run, firefox.exe "%NewScriptPath%"
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
