/**
 * The *proper* way to restart the shell
 */
RestartShell:
	WinGet, h, ID, ahk_class Progman	        ; use ahk_class WorkerW for XP
	PostMessage, 0x12, 0, 0, , ahk_id %h%	;wm_quit
	Sleep, 25
	Run, %A_WinDir%\explorer.exe
Return

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

/**
 * New File
 *
 * Create a new file in the current folder,
 * just like Ctrl+Shift+N
 */
NewFile:
	Path := GetCurrentFolderPath()
	Path := (Path = "") ? A_Desktop : Path

	;Create a file
	InputBox, FileName, Filename, Please enter a filename with extension., ,250, 150
	SplitPath, FileName, , , Ext

	If (FileName != "")
		If (Ext == "") ; Default - Text File
			FileAppend, , %Path%\%FileName%.txt
		Else
			FileAppend, , %Path%\%FileName%
Return

/**
 * Get the path of currently open folder.
 *
 * Use Path := (Path = "") ? "C:\" : Path
 * to handle exceptions and set a default path
 *
 * Todo: Handle CLSID for special folders
 */
GetCurrentFolderPath() {
	If WinActive("ahk_group Explorer_Group")
	{
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
		Return %path%
	}
	Else If WinActive("ahk_group Desktop_Group")
		Return %A_Desktop%
	Else
		Return ""
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
