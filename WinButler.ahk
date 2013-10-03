/**
 * Windows Butler
 *
 * A utility to make living on windows that bit easier.
 *
 * @dufferzafar
 */

/**
 * Script Settings
 *
 * Do not touch if you are unsure of anything.
 */
#NoEnv
#SingleInstance Force
#Persistent
#NoTrayIcon
#KeyHistory 0
SetWorkingDir %A_ScriptDir%

Version := "v1.3.5"

/**
 * Global Variables
 *
 * Edit only if you are sure enough.
 */

; The folder path where your screenshots will be saved
Screenshot_Directory := "C:\Users\" . A_Username . "\Pictures\Screenshots"
FileCreateDir, % Screenshot_Directory

; The output file format of the screenshots
; Can be any one of png, jpg, bmp
Screenshot_Format := "png"

; The factor by which the screenshot will be reduced
; 1.0 = Original Size,
; 0.5 = Half the original,
; 0.25 = Quarter of original and so on.
Screenshot_Size := 1.0

; ######################## Script Begins ########################

OnExit, Exit

; Create a group of explorer windows
GroupAdd, Explorer, ahk_class CabinetWClass
GroupAdd, Explorer, ahk_class Progman

; Modify the Menu
Menu, Tray, NoStandard
Menu, Tray, Tip, Windows Butler v0.9

Menu, Tray, Add, &Suspend, SuspendMe
Menu, Tray, Add, &Exit, CloseMe

; Set the icon if it exist
IfExist, %A_ScriptDir%\Data\Butler.ico
	Menu, Tray, Icon, %A_ScriptDir%\Data\Butler.ico

Menu, Tray, Icon	;Else show default icon

; Let the user know we have started
TrayTip, Windows Butler %Version%,
(

Hey! I'm right here...

Consult readme for usage instructions.
)
SetTimer, RemoveTrayTip, 2500

/**
 * Hotkey List
 *
 * ! = Alt
 * ^ = Ctrl
 * + = Shift
 * # = Windows Key
 *
 * Change hotkeys. Turn them On/Off.
 */

; Hotkey, 	KeyName,	Label, 			Options

Hotkey, 		^+Esc, 	RunTaskMan, 		On
Hotkey, 		!^r, 		RunRegedit, 		On
Hotkey, 		!^s, 		SaveText, 			On
Hotkey, 		#t, 		TopMost, 			On
Hotkey, 		!^d, 		OneLook, 			On

Hotkey, 		^Space, 	RunScriptlet, 		On

Hotkey, 		^+q, 		HelpLUA, 			On
Hotkey, 		^+a, 		HelpAHK, 			On
Hotkey, 		^+z, 		HelpPHP, 			On

; Run files open in sublime text
Hotkey, IfWinActive, ahk_class PX_WINDOW_CLASS
Hotkey, 		^+s, 		RunFromSublime, 	On
Hotkey, IfWinActive

; Paste text in command prompt
Hotkey, IfWinActive, ahk_class ConsoleWindowClass
Hotkey, 		^v, 		PasteClipboard, 	On
Hotkey, IfWinActive

; Extend windows explorer
Hotkey, IfWinActive, ahk_group Explorer
Hotkey, 		#y, 		ToggleExt, 			On
Hotkey, 		#j, 		ToggleHidden, 		On
Hotkey, 		#c, 		RunCMD, 				On
Hotkey, IfWinActive

/**
 * Check whether GDI+ is ready, if not - disable screener functions
 */

If !pToken := Gdip_Startup()
{
   MsgBox, 48, Windows Butler - GDI+ Error!, GDI+ is required for screenshot capabilities and it failed to load.`n`nScreenshot shortcuts will be Disabled.

   ; Disable Screener Hotkeys
   Hotkey, 		PrintScreen, 		GrabScreen, 			Off
	Hotkey, 		+PrintScreen, 		GrabWindow, 			Off
}
Else
{
	; Enable Screener Hotkeys
	Hotkey, 		PrintScreen, 		GrabScreen, 			On
	Hotkey, 		+PrintScreen, 		GrabWindow, 			On
}

Return	 ; End of Auto Execute Section

/**
 * Some Dirty Hostrings
 *
 * Mostly to avoid common grammar mistakes
 */

::i::I
::i'd::I'd
::i've::I've
::i'll::I'll
::i'm::I'm

/**
 * Searches for related words for the currently selected word.
 *
 * Opens a Chrome tab with onelookup reverse search.
 */

OneLook:
	tmp = %ClipboardAll% 	;save clipboard
	Clipboard := "" 			;clear
	Send, ^c 					;copy the selection
	ClipWait, 3
	selection = %Clipboard% ;save the selection
	Clipboard = %tmp% 		;restore old content of the clipboard

	If selection <> 			;if something is selected
	{
		url := "http://www.onelook.com/?w=*:" . selection
		Run, chrome.exe %url%
	}
Return

/**
 * Grab and save screenshots to a folder.
 *
 * Modify global variables to alter behaviour.
 */

GrabScreen:
	Screenshot(Screenshot_Size, Screenshot_Format, "Screen")
Return

GrabWindow:
	Screenshot(Screenshot_Size, Screenshot_Format, "Window")
Return

/**
 * Run the currently open file in Sublime Text
 *
 * Adjusts PHP/HTML files to take localhost into account
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

		If InStr(wTitle, ".lua") or InStr(wTitle, ".ahk")
		{
			SplitPath, wTitle,,workingDir
			Run, %ScriptPath%, %workingDir%
		}
		Else If InStr(wTitle, ".md")
		{
			Send, !m
		}
		Else If InStr(wTitle, ".php") or InStr(wTitle, ".html")
		{
			StringReplace, NewScriptPath, ScriptPath,% "C:\xampp\htdocs\", % "http://localhost/"
			Run, chrome.exe "%NewScriptPath%"
		}
		Else
			Run, %ScriptPath%
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
	tmp = %ClipboardAll% 	;save clipboard
	Clipboard := "" 			;clear
	Send, ^c 					;copy the selection
	ClipWait, 3
	selection = %Clipboard% ;save the selection
	Clipboard = %tmp% 		;restore old content of the clipboard

	If selection <> 			;if something is selected
	{
		;Create a file
		InputBox, FileName, Filename, Please enter a filename with extension., ,250, 150
		SplitPath, FileName, , , Ext

		If (FileName != "")
			If (Ext == "") ; Default - Text File
				FileAppend, %selection%, %A_Desktop%\%FileName%.txt
			Else
				FileAppend, %selection%, %A_Desktop%\%FileName%
	}
Return

/**
 * Run Task Manager and Registry Editor
 *
 * Applications are run after removing any administrator restrictions (usually caused by viruses)
 */
RunTaskMan:
	RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Policies
	RegDelete, HKCU, Software\Microsoft\Windows NT\CurrentVersion\TaskManager

	RegDelete, HKLM, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

	RegDelete, HKLM, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon, DisableCAD
	RegDelete, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, DisableTaskMgr

	Run Taskmgr.exe
Return

; Also deletes the "LastKey". So, basically starts from scratch
RunRegedit:
	RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Policies
	RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey

	Run Regedit.exe, , Max
Return

/**
 * Scriptlet Library
 *
 * Make sure the additional ahk exists.
 */
RunScriptlet:
	IfWinExist, My Scriptlet Library
	{
		PostMessage, 0x112, 0xF060,,, My Scriptlet Library
	}
	Else
	{
		ScriptletPath := A_ScriptDir . "\data\scriptLib\Scriptlet Library.ahk"
		SplitPath, ScriptletPath,,ScriptletDir
		Run, %ScriptletPath%, %ScriptletDir%
	}
Return


/**
 * Always On Top
 *
 * The "current" window becomes the topmost.
 */
TopMost:
	WinSet, AlwaysOnTop, Toggle, A
Return

/**
 * Launch Help Files
 *
 * Make sure the paths are correct
 */
HelpAHK:
	SplitPath, A_AhkPath,, ahk_dir

	If wnd := WinExist("AutoHotkey_L Help")
		WinActivate, ahk_id %wnd%
	Else
		Run, %ahk_dir%\AutoHotkey.chm, , Max
Return

HelpLUA:
	Run, D:\I`, Coder\Scripts`, Codes & Tut\Lua\[Help]\Pdf\luaaio.chm, , Max
Return

HelpPHP:
	Run, D:\I`, Coder\Scripts`, Codes & Tut\PHP\php.chm, , Max
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
 * Run CMD
 *
 * Run command prompt in the current folder
 */
RunCMD:
	;Get the full path from the address bar
	WinGetText, full_path, A

	;Split on newline (`n)
	StringSplit, word_array, full_path, `n

	; Take the first element from the array
	full_path = %word_array1%

	;Remove all carriage returns (`r)
	StringReplace, full_path, full_path, `r, , all
	StringTrimLeft, full_path, full_path, 9

	IfInString full_path, \
	{
		Run, cmd /K cd /D "%full_path%"
	}
	else ;If path is not valid
	{
		Run, cmd /K cd /D "C:\ "
	}
Return

/**
 * Used to send clipboard data to command prompt
 */
PasteClipboard:
	SendRaw %clipboard%
Return

/**
 * Miscellaneous Subroutines
 */

; The screenshot function:
Screenshot(Size,FileType,Type)
{
	Global Screenshot_Directory
	sW := A_ScreenWidth, sH := A_ScreenHeight
	WinGetPos, X, Y, W, H, A
	If (Type = "Window")
	{
		pBitmap := Gdip_BitmapFromScreen((X>0?X:0) "|" (Y>0?Y:0) "|" (W<sW?W:sW) "|" (H<(sH-40)?H:(sH-40)))
		FileName = Window-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%
	}
	Else
	{
		pBitmap := Gdip_BitmapFromScreen()
		FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%
	}

	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	PBitmapResized := Gdip_CreateBitmap(Round(Width*Size), Round(Height*Size))
	G := Gdip_GraphicsFromImage(pBitmapResized), Gdip_SetInterpolationMode(G, 7)
	Gdip_DrawImage(G, pBitmap, 0, 0, Round(Width*Size), Round(Height*Size), 0, 0, Width, Height)

	; ToolTip, % "Saving To - " Screenshot_Directory "\" FileName "." FileType
	; SetTimer, RemoveToolTip, 1000
	Gdip_SaveBitmapToFile(PBitmapResized, Screenshot_Directory "\" FileName "." FileType)	;Save to file

	Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapResized), Gdip_DisposeImage(pBitmap)
}

Refresh()
{
    WinGetClass, eh_Class, A
    If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
        Send, {F5}
	Else PostMessage, 0x111, 28931,,, A
}

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

Exit:
	Gdip_Shutdown(pToken)
CloseMe:
	ExitApp