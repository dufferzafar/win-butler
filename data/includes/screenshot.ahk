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