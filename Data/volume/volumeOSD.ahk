/**
 * Get the currently playing song and add it to the
 * overlay
 *
 * WinGetTitle, CurrentSong, ahk_class WMPlayerApp
 */

MWheelUp:
	If IsMouseOverTaskbar()
		Gosub, VolumeUp
	Else
		Send, {WheelUp}
Return

MWheelDown:
	If IsMouseOverTaskbar()
		Gosub, VolumeDown
	Else
		Send, {WheelDown}
Return

Build_VolOSD:
	;Create a layered window
	Gui, 97:-Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow
	hVolumeOSD := WinExist()
Return

VolumeUp:
	iOldMaster := VA_GetMasterVolume()
	iNewMaster := (iOldMaster + 5.00) > 100 ? 100 : (iOldMaster + 5.00)
	VA_SetMasterVolume(iNewMaster)

	; This only works because I have Windows Media Player Plus! plugin enabled
	; Get the plugin and enable currently playing media in title bar
	; %title%[ - %artist%] - Windows Media Player
	SetTitleMatchMode, 2 ; Match title anywhere
	WinGetTitle, Title, Windows Media Player
	RegExMatch(Title, "^(.*) - (.*) - Windows Media Player", Song)

	VolumeOSD(hVolumeOSD, iNewMaster, Song1 = "" ? "Volume" : Song1)

	SetTimer, HideGui, -750
Return

VolumeDown:
	iOldMaster := VA_GetMasterVolume()
	iNewMaster := (iOldMaster - 5.00) < 0 ? 0 : (iOldMaster - 5.00)
	VA_SetMasterVolume(iNewMaster)

	SetTitleMatchMode, 2 ; Match title anywhere
	WinGetTitle, Title, Windows Media Player
	RegExMatch(Title, "^(.*) - (.*) - Windows Media Player", Song)

	VolumeOSD(hVolumeOSD, iNewMaster, Song1 = "" ? "Volume" : Song1)
	SetTimer, HideGui, -750
Return

HideGui:
	Gui, 97:Hide
Return

IsMouseOverTaskbar()
{
	CoordMode, Mouse, Screen
	MouseGetPos, , , WindowUnderMouseID
	WinGetClass, winclass , ahk_id %WindowUnderMouseID%
	result:=false
	if(winclass="Shell_TrayWnd")
		result:=true
	return result
}

;hwnd       - Handle of the GUI
;iX         - X coordinate of the GUI
;iY         - Y coordinate of the GUI
;sText      - Text to display
;iProgress  - Percentage value of the progress bar (eg. 50) - can have decimals
;sProgText  - Text to display on top of the progress bar
;cText      - Forecolor of sText in ARGB
;cProgFill  - Color of the progress bar in ARGB
;cProgShape - Color of the outline of the progress bar in ARGB
;cPercent   - Forecolor of sProgText in ARGB

; VolumeOSD(hwnd, iX, iY, sText, iProgress, sProgText, cText, cProgFill, cProgShape, cPercent)
VolumeOSD(hwnd, iProgress, sText)
{
	;ScreenCenter
	iX := (A_ScreenWidth - 200) / 2
	iY := (A_ScreenHeight - 170) / 2

	;Default Text
	; sText := "Volume"

	;Deafault Progress Bar Text
	sProgText := Round(iProgress) "%"

	;Default Colours
	cText := 0xFFCCCCCC
	cProgFill := 0xFF0F0FFF
	cProgShape := 0xFF000000
	cPercent := 0xFFFFFFFF

	;Width and Height of Gui
	iW := 200, iH := 50

	;Regular GDI stuff
	hbm := CreateDIBSection(iW, iH), hdc := CreateCompatibleDC()
	obm := SelectObject(hdc, hbm), G := Gdip_GraphicsFromHDC(hdc)
	Gdip_SetSmoothingMode(G, 4)

	pBrush := Gdip_BrushCreateSolid(0xCC000000)
	Gdip_FillRoundedRectangle(G, pBrush, 0, 0, iW, iH, 10)
	Gdip_DeleteBrush(pBrush)

	;Fix cText and cPercent so that they become option compatible with Gdip_TextToGraphic()
	cText := "c" SubStr(cText, 3), cPercent := "c" SubStr(cPercent, 3)

	;Draw the main text at (6, 6) in specified color
	Options = x6 y6 %cText% r4 s12
	Gdip_TextToGraphics(G, sText, Options, "Arial")

	;Fill the shape
	pBrush := Gdip_BrushCreateSolid(cProgFill)
	Gdip_FillRoundedRectangle(G, pBrush, 8, 28, (iProgress / 100) * (iW - 16), 15, (iProgress >= 2) ? 2 : 0)
	Gdip_DeleteBrush(pBrush)

	;Outline the progress bar
	pBorderPen := Gdip_CreatePen(cProgShape, 1)
	Gdip_DrawRoundedRectangle(G, pBorderPen, 8, 28, iW - 16, 15, 2)
	Gdip_DeletePen(pBorderPen)

	;Draw the progress bar text over the progress bar in specified color with AA at size 10
	Options := "x8 y29 h14 w" (iW - 16) " " cPercent " r4 s12 Center Bold"
	Gdip_TextToGraphics(G, sProgText, Options, "Arial")

	;Update the specified window we have created with a handle to our bitmap
	UpdateLayeredWindow(hwnd, hdc, iX, iY, iW, iH)

	;Regular GDI Cleanup
	SelectObject(hdc, obm),	DeleteObject(hbm)
	DeleteDC(hdc),	Gdip_DeleteGraphics(G)

	;Show the GUI if it's not showing already
	If Not DllCall("IsWindowVisible", "UInt", hwnd)
		DllCall("ShowWindow", "UInt", hwnd, "UInt", 8)  ;SW_SHOWNA
	; Return
}
