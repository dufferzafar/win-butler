/**
 * Launches Everything in the current directory
 */

FindEverything:
	; Todo: Settings - Get Everything Path
	EverythingPath := "F:\PowerPack\Everything"

	If WinActive("ahk_class ThunderRT6FormDC")
		Path := GetPathFromXYplorer()
	Else
		Path := GetCurrentFolderPath()

	Run, %EverythingPath%\Everything.exe -path "%Path%\\", %EverythingPath%
Return

/**
 * Some Improvements to the default settings of QtTabBar
 *
 * Ctrl+PgDn is the same as Ctrl+Tab
 * Ctrl+PgUp is the same as Ctrl+Shift+Tab
 */

; Todo: Map these to other applications too.
QtTabDn:
	Send, ^{Tab}
Return

QtTabUp:
	Send, ^+{Tab}
Return

/**
 * I trust and like AHK commands more than the default functions
 */
MinimizeWindow:
	; Send, #m
	WinMinimize, A
Return

GoUpwardDirectory:
	If !InStr(GetCurrentFolderPath(), ".search-ms")
		Send !{Up}
	Else
		Send {Backspace}
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
		If InStr(path, ".library-ms")
			Return ""
		Else
			Return path
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

RefreshTray() {
	WM_MOUSEMOVE := 0x200

	ControlGetPos, xTray,, wTray,, ToolbarWindow321, ahk_class Shell_TrayWnd
	endX := xTray + wTray
	x := 5, y := 12 ; Hackety Hack :)

	Loop
	{
		if (x > endX)
			break
		point := (y << 16) + x
		PostMessage, %WM_MOUSEMOVE%, 0, %point%, ToolbarWindow321, ahk_class Shell_TrayWnd
		x += 18
	}
}


ReStartExplorer:    ; SKAN, CD:07-Dec-2013 LM:14-Dec-2014 | goo.gl/UnS2rl
 ;  Credit: Gracefully Exit Explorer (Programmatically) - Stack Overflow   | goo.gl/tAA9HY
 ;  Thanks to chaz - http://ahkscript.org/boards/viewtopic.php?p=7099#p7099

	WaitSecs = 3

	If A_OSVersion not in WIN_XP,WIN_VISTA,WIN_7
		Return

	If ( A_OSVersion = "WIN_XP" )
	{
		WinGet, ShellPID, PID,     ahk_class Progman
		PostMessage, 0x012, 0, 0,, ahk_class Progman        ; WM_QUIT = 0x12
	}
	Else
	{
		WinGet, ShellPID, PID,     ahk_class Shell_TrayWnd
		PostMessage, 0x5B4, 0, 0,, ahk_class Shell_TrayWnd  ; WM_USER + 0x1B4
	}

	Process, WaitClose, %ShellPID%, %WaitSecs%
	IfEqual, ErrorLevel, 0, Run %A_WinDir%\explorer.exe
Return
