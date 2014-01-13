/**
 * Searches for related words for the currently selected word.
 *
 * Opens a Chrome tab with onelookup reverse search.
 *
 * Modified: Sublime's setting so that Ctrl+C does nothing
 * if selection is empty.
 */
OneLook:
   tmp = %ClipboardAll%    ;save clipboard
   Clipboard := ""         ;clear
   Send, ^c                ;copy the selection
   ClipWait, 1
   selection = %Clipboard% ;save the selection
   Clipboard = %tmp%       ;restore old content of the clipboard

   If (selection != "")    ;if something is selected
   {
      url := "http://www.onelook.com/?w=*:" . selection
      Run, firefox.exe "%url%"
   }
Return

/**
 * Save selected text to a file
 *
 * Just select some text and Press Alt+Ctrl+S.
 * Enter the filename. Press Enter.
 *
 * The file will be saved to the desktop :)
 */
SaveText:
   selection := GetSelectedText()
   ; MsgBox, % Selection
   If (selection != "")    ;if something is selected
   {
      ;Create a file
      InputBox, FileName, Filename, Please enter a filename with extension., ,250, 150
      SplitPath, FileName, , , Ext

      If (FileName != "")
         If (Ext == "") ; Default - Text File
            FileAppend, %selection%, %A_Desktop%\%FileName%.txt
         Else If (Ext == "ahk") or (Ext == "py")
            FileAppend, %selection%, C:\Users\dufferzafar\Downloads\Scripts\%FileName%
         Else
            FileAppend, %selection%, %A_Desktop%\%FileName%
   }
Return

/**
 * SaveRunScript
 *
 * Saves the currently selected text to an AHK
 * script and then runs it.
 */
SaveRunScript:
   selection := GetSelectedText()
   ; MsgBox, % Selection
   If (selection != "")    ;if something is selected
   {
      Path := "C:\Users\dufferzafar\Downloads\Scripts"
      WinGetActiveTitle, Title
      Title := SubStr(Title, 1, 15)
      ; FileName = %Title%-%A_Hour%-%A_Min%-%A_Sec%.ahk
      FileName = %A_Hour%-%A_Min%-%A_Sec%.ahk
      FileAppend, %selection%, %Path%\%FileName%
      Run, %Path%\%FileName%, %Path%
   }
Return
