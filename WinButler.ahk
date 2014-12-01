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

Version := "v3.4", Version_Date := "2/9/2014"

; ####################### User Settings ########################

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

; ####################### Script Begins ########################

OnExit, Exit

; Build traymenu, show traytip
Gosub, Build_TrayMenu ; <traymenu.ahk>
Gosub, Show_TrayMenu

; Build the main gui
Gosub, Build_MainGui ; <gui.ahk>

; An explorer addon to select files
Gosub, Build_SelectFiles_Gui ; <selectfiles.ahk>

; Volume control display
Gosub, Build_VolOSD ; <volosd.ahk>

; Turn On/Off various hotkeys
Gosub, Activate_Hotkeys ; <hotkeys.ahk>

; Setup and Start Automated Backups
Gosub, Setup_BackupBuddy ; <backup.ahk>

; Used by <cursor.ahk>
CursorHidden := False
SystemCursor("INIT")

; Ensure always running apps
SetTimer, AlwaysRunning, % 10 * 60 * 1000 ; <applications.ahk>

; Delay some applications on startup
SetTimer, StartupDelay,  % -1 * 60 * 1000 ; <applications.ahk>

; Create a jrnl entry every sixty minutes
; SetTimer, Jrnl,  % 60 * 60 * 1000 ; <applications.ahk>

; Required for screenshots
Gdip_Startup() ; <gdip.ahk> (thank you tic)

; Wait for headphones to be connected
; Gosub, SetupHeadphones

Return			; End of the auto-execute section
; Everything below this line is a separate thread,
; and will have no effect unless explicitly called,
; except for the #includes, they are pre-processed.

CapsLock::SendInput, {BS}
^CapsLock::SendInput, ^{BS}

!CapsLock::SendInput, {Del}
+CapsLock::SendInput, +{Del}

; ######################## Script Ends #########################

/**
 * Debugging related
 */

^F12::
	dbg := Debug("Hotkeys") ; Debugger
	Msgbox, % dbg
Return

; ^+r::Reload

/**
 * Always On Top
 *
 * The "current" window becomes the topmost.
 */
TopMost:
	WinSet, AlwaysOnTop, Toggle, A
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

Exit:
	Gdip_Shutdown(pToken)
CloseMe:
	ExitApp

/**
 * Include Dependencies
 */

; BuildTrayMenu and associated handlers
#Include Data\includes\traymenu.ahk

; Hotkeys and Hotstrings
#Include Data\includes\hotkeys.ahk
#Include Data\includes\hotstrings.ahk

; BuildGui and related handlers
#Include Data\includes\gui.ahk

; Debugging related functions
#Include Data\includes\debug.ahk

; ------------------------------------------

	; Autobackup functionality
	#Include Data\buddy\backup.ahk

	; WinExplorer improvements
	#Include Data\includes\explorer.ahk

	; WinExplorer improvements
	#Include Data\includes\maximize.ahk

	; XYplorer thingies
	#Include Data\includes\XYplorer.ahk

	; Select files in explorer
	#Include Data\includes\selectfiles.ahk

	; Registry Editor launch/jump
	#Include Data\includes\registry.ahk

	; Closes application via Ctrl+W
	#Include Data\includes\close.ahk

	; Console2 and Command prompt
	#Include Data\includes\console.ahk

	; Focus various controls
	#Include Data\includes\focus.ahk

; ------------------------------------------

	; Select something and do something
	#Include Data\includes\selections.ahk

	; Run based hotkeys like RunTaskMan and HelpFolder
	#Include Data\includes\run.ahk

	; Run files directly to/from sublime
	#Include Data\includes\sublime.ahk

; ------------------------------------------

	; Run applications present on system
	#Include Data\includes\applications.ahk

; ------------------------------------------

	; Needed for Screenshot features
	#Include Data\includes\Gdip_All.ahk

	; Screencapture related functions
	; #Include Data\screenshot\screenshot.ahk

	; JSON library used to handle response from Imgur
	; #Include Data\screenshot\json.inc.ahk

; ------------------------------------------

	; Hide/Show Cursor
	#Include Data\includes\cursor.ahk

; ------------------------------------------

	; Needed for Volume Control on Windows 7
	#Include Data\volume\VA.inc.ahk

	; Control Volume
	#Include Data\volume\volumeOSD.ahk

	; Reduce volume when earphones are connected
	; #Include, Data\volume\headphones.ahk

; ------------------------------------------

	; Display a beautiful timer and say goodbye
	#Include Data\includes\autoshutdown.ahk
