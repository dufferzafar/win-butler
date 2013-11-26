; ^f9::GetCurrentFolder7()
; ^f8::GetShellFolderPath()
; Return

/**
 * Get the path of currently open folder.
 *
 * Todo: Change to COM. SFV.
 */
GetCurrentFolder7() {
	;Get the full path from the address bar
	WinGetText, full_path, A

	;Split on newline (`n)
	StringSplit, word_array, full_path, `n

	; Take the first element from the array
	full_path = %word_array1%

	;Remove all carriage returns (`r)
	StringReplace, full_path, full_path, `r, , all
	StringTrimLeft, full_path, full_path, 9
	; Msgbox, % full_path
	; Run, % full_path
	return full_path
}

; Todo: This one sends the CLSID or something for special folders
; Try to use that somehow ??
GetShellFolderPath() {
  hWnd := WinExist("A")
  shellApp := ComObjCreate("Shell.Application")

  for Item in shellApp.Windows
  {
    If (Item.hwnd = hWnd)
    {
      sfv := Item.Document ; ShellFolderView
      path := sfv.Folder.Self.Path
    }
  }
  Msgbox, % path
  Run, % path
}

/**
 * Refresh Explorer's View
 */
Refresh() {
	WinGetClass, eh_Class, A
	If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
		Send, {F5}
	Else PostMessage, 0x111, 28931,,, A
}

/**
 * GetSelectedText or FilePath in Windows Explorer
 *
 * by Learning one
 */
GetSelectedText() {
	IsClipEmpty := (Clipboard = "") ? 1 : 0

	If !IsClipEmpty
	{
		ClipboardBackup := ClipboardAll
		While !(Clipboard = "")
		{
			Clipboard =
			Sleep, 10
		}
	}

	Send, ^c
	ClipWait, 0.1

	ToReturn := Clipboard, Clipboard := ClipboardBackup

	If !IsClipEmpty
		ClipWait, 0.5, 1

	; Msgbox, %ToReturn%

	Return ToReturn
}

/**
 * Some Improvements to the default settings of QtTabBar
 *
 * Ctrl+PgDn is the same as Ctrl+Tab
 * Ctrl+PgUp is the same as Ctrl+Shift+Tab
 */

QtTabDn:
	Send, ^{Tab}
Return

QtTabUp:
	Send, ^+{Tab}
Return

Minimize:
	; Send, #m
	WinMinimize, A
Return

/**
 * New File
 *
 * Create a new file in the current folder,
 * just like Ctrl+Shift+N
 */
NewFile:
	full_path := GetCurrentFolder7()
	IfInString full_path, \
	{
		;Create a file
		InputBox, FileName, Filename, Please enter a filename with extension., ,250, 150
		SplitPath, FileName, , , Ext

		If (FileName != "")
			If (Ext == "") ; Default - Text File
				FileAppend, , %full_path%\%FileName%.txt
			Else
				FileAppend, , %full_path%\%FileName%
	}
Return

/**
 * Toggle Extension
 *
 * Show/Hide file extensions.
 */
ToggleExt:
	RegRead, FileExt_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt
	If FileExt_Status = 1
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 0
	Else
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 1
	Refresh()
Return

/**
 * Toggle Hidden Files
 *
 * Show/Hide hidden files and folders.
 */
ToggleHidden:
	RegRead, SuperHidden_Status, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden
	If SuperHidden_Status = 0
		{
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 1
		}
	Else
		{
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, ShowSuperHidden, 0
		}
	Refresh()
Return
