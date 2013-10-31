#Include VA.ahk
#SingleInstance force

;You first need to start up GDI+
pToken := Gdip_Startup()

;So that we can shutdown GDI+ nicely
OnExit, ExitingApp

;Create a layered window
Gui, 1:-Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow
hGui1 := WinExist()

; Get the master volume of the default playback device.
; iOldMaster := VA_GetMasterVolume()
; VolumeOSD(hGui1, iOldMaster, 0xFFCCCCCC, (bMaster = "OFF") ? 0xFF0F0FFF : 0xFFFF0000)

<^>!^Up::
	iOldMaster := VA_GetMasterVolume()

	iNewMaster := (iOldMaster + 5.00) > 100 ? 100 : (iOldMaster + 5.00)

	VA_SetMasterVolume(iNewMaster)

	VolumeOSD(hGui1, iNewMaster, 0xFFCCCCCC, (bMaster = "OFF") ? 0xFF0F0FFF : 0xFFFF0000)

	SetTimer, HideGui, -1000
Return

<^>!^Down::
	iOldMaster := VA_GetMasterVolume()

	iNewMaster := (iOldMaster - 5.00) < 0 ? 0 : (iOldMaster - 5.00)

	VA_SetMasterVolume(iNewMaster)

	VolumeOSD(hGui1, iNewMaster, 0xFFCCCCCC, (bMaster = "OFF") ? 0xFF0F0FFF : 0xFFFF0000)
	SetTimer, HideGui, -1000
Return

HideGui:
	Gui, 1:Hide
Return

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
VolumeOSD(hwnd, iProgress, cText, cProgFill)
{
	;ScreenCenter
	iX := (A_ScreenWidth - 200) / 2
	iY := (A_ScreenHeight - 170) / 2

	;Default Text
	sText := "Master Volume"

	;Deafault Progress Bar Text
	sProgText := Round(iProgress) "%"

	;Default Colours
	cProgShape := 0xFF000000
	cPercent := 0xFFFFFFFF

	;Width and Height of Gui
	iW := 200, iH := 50

	;Create a GDI bitmap
	hbm := CreateDIBSection(iW, iH)

	;Get a device context compatible with the screen
	hdc := CreateCompatibleDC()

	;Select the bitmap into the device context
	obm := SelectObject(hdc, hbm)

	;Get a pointer to the graphics of the bitmap, for use with drawing functions
	G := Gdip_GraphicsFromHDC(hdc)

	;Set the smoothing mode to antialias = 4 to make shapes appear smother
	Gdip_SetSmoothingMode(G, 4)

	;Create a partially transparent to draw a rounded rectangle with
	pBrush := Gdip_BrushCreateSolid(0xCC000000)

	;Fill the graphics of the bitmap with a rounded rectangle using the brush created
	Gdip_FillRoundedRectangle(G, pBrush, 0, 0, iW, iH, 10)

	;Delete the brush as it is no longer needed and wastes memory
	Gdip_DeleteBrush(pBrush)

	;Fix cText and cPercent so that they become option compatible with Gdip_TextToGraphic()
	cText := "c" SubStr(cText, 3), cPercent := "c" SubStr(cPercent, 3)

	;Draw the main text at (6, 6) in specified color with AA at size 16
	Options = x6 y6 %cText% r4 s16
	Gdip_TextToGraphics(G, sText, Options, "Arial")

	;It's now time to fill the shape. Prepare a brush
	pBrush := Gdip_BrushCreateSolid(cProgFill)

	;Fill the shape
	Gdip_FillRoundedRectangle(G, pBrush, 8, 28, (iProgress / 100) * (iW - 16), 15, (iProgress >= 2) ? 2 : 0)

	;We're done with the brush now
	Gdip_DeleteBrush(pBrush)

	;Create a pen for the outline of the progress bar
	pBorderPen := Gdip_CreatePen(cProgShape, 1)

	;We can now draw the outline
	Gdip_DrawRoundedRectangle(G, pBorderPen, 8, 28, iW - 16, 15, 2)

	;We're done with the pen now
	Gdip_DeletePen(pBorderPen)

	;Draw the progress bar text over the progress bar in specified color with AA at size 10
	Options := "x8 y29 h14 w" (iW - 16) " " cPercent " r4 s12 Center Bold"
	Gdip_TextToGraphics(G, sProgText, Options, "Arial")

	;Update the specified window we have created with a handle to our bitmap
	UpdateLayeredWindow(hwnd, hdc, iX, iY, iW, iH)

	; Select the object back into the hdc
	SelectObject(hdc, obm)

	; Now the bitmap may be deleted
	DeleteObject(hbm)

	; Also the device context related to the bitmap may be deleted
	DeleteDC(hdc)

	; The graphics may now be deleted
	Gdip_DeleteGraphics(G)

	;Show the GUI if it's not showing already
	If Not DllCall("IsWindowVisible", "UInt", hwnd)
	DllCall("ShowWindow", "UInt", hwnd, "UInt", 8)  ;SW_SHOWNA

	Return
}

;Shutdown GDI+ and get out
Esc::
ExitingApp:
    Gdip_Shutdown(pToken)
ExitApp