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
SendMode, Input

Version := "v2.1"

; The folder path where your screenshots will be saved
Screenshot_Directory := "C:\Users\" . A_Username . "\Pictures\Screenshots"
FileCreateDir, % Screenshot_Directory

; The folder path where your imgur uploads will be saved
Imgur_Directory := "C:\Users\" . A_Username . "\Pictures\OnImgur"
FileCreateDir, % Imgur_Directory
FileCreateDir, % Imgur_Directory . "\ImgurData"

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
Menu, Tray, Tip, Windows Butler ; %Version%

Menu, ScreenShot_Menu, Add, % "Ratio: 25%", ScreenShot_Menu_Handler
Menu, ScreenShot_Menu, Add, % "Ratio: 50%", ScreenShot_Menu_Handler
Menu, ScreenShot_Menu, Add, % "Ratio: 75%", ScreenShot_Menu_Handler
Menu, ScreenShot_Menu, Add, % "Ratio: 100%", ScreenShot_Menu_Handler

Menu, Tray, Add, Screenshot, :ScreenShot_Menu
Menu, Tray, Add
Menu, Tray, Add, &Suspend, SuspendMe
Menu, Tray, Add, &Exit, CloseMe

Menu, ScreenShot_Menu, Check, % "Ratio: 100%"
Ratio_LastMenuItem := "Ratio: 100%"

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
SetTimer, RemoveTrayTip, 3000

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

; CapsLock Be Gone!!
SetCapsLockState, AlwaysOff

; Hotkey, 	KeyName,	Label, 			Options

Hotkey, 		^+Esc, 	RunTaskMan, 		On
Hotkey, 		!^r, 		RunRegedit, 		On
Hotkey, 		#t, 		TopMost, 			On
Hotkey, 		!^d, 		OneLook, 			On

Hotkey, 		!^s, 		SaveText, 			On
Hotkey, 		!+s, 		SaveRunScript,		On

Hotkey, 		#Space, 	RunScriptlet, 		On

Hotkey, 		^+q, 		HelpPython, 		On
Hotkey, 		^+a, 		HelpAHK, 			On
Hotkey, 		^+z, 		HelpFolder, 		On

Hotkey, 		!^c, 		RunConsole,			On

Hotkey, 		#Down, 	Minimize,		 	On
Hotkey, 		#s, 		AutoShutdown,		On

Hotkey, 		^Up, 		VolumeUp,			On
Hotkey, 		^Down, 	VolumeDown,			On

; Run files open in sublime text
Hotkey, IfWinActive, ahk_class PX_WINDOW_CLASS
Hotkey, 		^+s, 		RunFromSublime, 	On
Hotkey, IfWinActive

; Paste text in command prompt
Hotkey, IfWinActive, ahk_class ConsoleWindowClass
Hotkey, 		^v, 		PasteClipboard, 	On
Hotkey, 		^w, 		CloseCMD, 			On
Hotkey, IfWinActive

; Extend windows explorer
Hotkey, IfWinActive, ahk_group Explorer
Hotkey, 		#y, 		ToggleExt, 			On
Hotkey, 		#j, 		ToggleHidden, 		On
Hotkey, 		!^f, 		OpenInSublime, 	On
Hotkey, 		^PgDn, 	QtTabDn,			 	On
Hotkey, 		^PgUp, 	QtTabUp,			 	On
Hotkey, IfWinActive

/**
 * Check whether GDI+ is ready, if not - disable screener functions
 */

If !pToken := Gdip_Startup()
{
   MsgBox, 48, Windows Butler - GDI+ Error!, GDI+ is required for screenshot capabilities and it failed to load.`n`nScreenshot shortcuts will be Disabled.
}
Else
{
	; Enable Screener Hotkeys
	Hotkey, 	PrintScreen, 	GrabScreen, 				On
	Hotkey, 	+PrintScreen, 	GrabAndUpload,				On
	Hotkey, 	^PrintScreen, 	GrabScreenSansTaskbar, 	On
	Hotkey, 	!PrintScreen, 	GrabWindow, 				On
	Hotkey, 	#LButton, 		GrabArea,					On
}

;Create a layered window
Gui, 97:-Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow
hVolumeOSD := WinExist()

Return	 ; End of Auto Execute Section

ScreenShot_Menu_Handler:
	If RegExMatch(A_ThisMenuItem, "^Ratio: (\d+)%$", Ratio)
	{
		ScreenShot_Size := (Ratio1 / 100)
		Menu, ScreenShot_Menu, Check, % A_ThisMenuItem
		Menu, ScreenShot_Menu, UnCheck, % Ratio_LastMenuItem
	}
Return

/**
 * Some Dirty Hostrings
 *
 */

; Avoid common grammar mistakes
::i::I
::i'd::I'd
::i've::I've
::i'll::I'll
::i'm::I'm

; My Octopress Blog.
::dz::dufferzafar.github.com

/**
 * WHY WAS THIS KEY CREATED?
 */
CapsLock::
	SendInput, {BS}
Return

^CapsLock::
	SendInput, ^{BS}
Return

+CapsLock::
	SendInput, {Del}
Return


/**
 * Searches for related words for the currently selected word.
 *
 * Opens a Chrome tab with onelookup reverse search.
 *
 * Todo: Sublime, nothing selected 'bug'
 */

OneLook:
	tmp = %ClipboardAll% 	;save clipboard
	Clipboard := "" 			;clear
	Send, ^c 					;copy the selection
	ClipWait, 1
	selection = %Clipboard% ;save the selection
	Clipboard = %tmp% 		;restore old content of the clipboard

	If (selection != "")		;if something is selected
	{
		url := "http://www.onelook.com/?w=*:" . selection
		Run, chrome.exe "%url%"
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
	If (selection != "")		;if something is selected
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
	If (selection != "")		;if something is selected
	{
		Path := "C:\Users\dufferzafar\Downloads\Scripts"
		WinGetActiveTitle, Title
		Title := SubStr(Title, 1, 15)
		FileName = %Title%-%A_Hour%-%A_Min%-%A_Sec%.ahk
		FileAppend, %selection%, %Path%\%FileName%
		Run, %Path%\%FileName%, %Path%
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
	Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\Lua AIO.chm", , Max
Return

HelpPython:
	Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\Python 330.chm", , Max
Return

HelpPHP:
	Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\php.chm", , Max
Return

HelpFolder:
	Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]"
Return

/**
 * Miscellaneous Subroutines
 */

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

/**
 * Include Dependencies
 */

; Registry Editor launch/jump
#Include Data\includes\registry.ahk

; WinExplorer improvements
#Include Data\includes\explorer.ahk

; Console2 and Command prompt
#Include Data\includes\console.ahk

; Run files directly to/from sublime
#Include Data\includes\runFromSublime.ahk

; Display a beautiful timer and say goodbye
#Include Data\includes\autoshutdown.ahk

; Screencapture related functions
#Include Data\screenshot\screenshot.ahk

; Needed for Screenshot features
#Include Data\Gdip.ahk

; JSON library used to handle response from Imgur
#Include Data\screenshot\json.inc.ahk

; Needed for Volume Control on Windows 7
#Include Data\volume\VA.inc.ahk

; Control Volume
#Include Data\volume\volumeOSD.ahk
