/**
 * Grab and save screenshots to a folder.
 *
 * Modify global variables to alter behaviour.
 */

GrabScreen:
	Screenshot("Screen")
Return

GrabWindow:
	Screenshot("Window")
Return

GrabScreenSansTaskbar:
	Screenshot("Screen-Taskbar")
Return

GrabArea:
	Area := SelectArea("cBlue")
	Sleep, 100
	Screenshot("Area", Area)
Return

; The screenshot function:
Screenshot(Type, Area="")
{
	Global Screenshot_Directory

	Size := 1.0, FileType := "png"

	sW := A_ScreenWidth, sH := A_ScreenHeight
	WinGetPos, X, Y, W, H, A

	If (Type = "Area")
	{
		pBitmap := Gdip_BitmapFromScreen(Area)
		FileName = Area-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%
	}
	Else If (Type = "Window")
	{
		WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
		pBitmap := Gdip_BitmapFromScreen((X>0?X:0) "|" (Y>0?Y:0) "|" (W<sW?W:sW) "|" (H<(sH-tbH)?H:(sH-tbH)))
		FileName = Window-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%
	}
	Else If(Type = "Screen")
	{
		pBitmap := Gdip_BitmapFromScreen()
		FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%
	}
	Else
	{
		WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
		pBitmap := Gdip_BitmapFromScreen(0 "|" 0 "|" sW "|" sH-tbH)
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

SelectArea(Options="") {	; by Learning one
   /*
   Returns selected area. Return example: 22|13|243|543
   Options: (White space separated)
   - c color. Default: Blue.
   - t transparency. Default: 50.
   - g GUI number. Default: 99.
   - m CoordMode. Default: s. s = Screen, r = Relative
   */
   CoordMode, Mouse, Screen
   MouseGetPos, MX, MY
   CoordMode, Mouse, Relative
   MouseGetPos, rMX, rMY
   CoordMode, Mouse, Screen
   loop, parse, Options, %A_Space%
   {
      Field := A_LoopField
      FirstChar := SubStr(Field,1,1)
      if FirstChar contains c,t,g,m
      {
         StringTrimLeft, Field, Field, 1
         %FirstChar% := Field
      }
   }
   c := (c = "") ? "Blue" : c, t := (t = "") ? "50" : t, g := (g = "") ? "99" : g , m := (m = "") ? "s" : m
   Gui %g%: Destroy
   Gui %g%: +AlwaysOnTop -caption +Border +ToolWindow +LastFound
   WinSet, Transparent, %t%
   Gui %g%: Color, %c%
   Hotkey := RegExReplace(A_ThisHotkey,"^(\w* & |\W)")
   While, (GetKeyState(Hotkey, "p"))
   {
      Sleep, 10
      MouseGetPos, MXend, MYend
      w := abs(MX - MXend), h := abs(MY - MYend)
      X := (MX < MXend) ? MX : MXend
      Y := (MY < MYend) ? MY : MYend
      Gui %g%: Show, x%X% y%Y% w%w% h%h% NA
   }
   Gui %g%: Destroy
   if m = s	; Screen
   {
      MouseGetPos, MXend, MYend
      If ( MX > MXend )
      temp := MX, MX := MXend, MXend := temp
      If ( MY > MYend )
      temp := MY, MY := MYend, MYend := temp
      Return MX "|" MY "|" MXend "|" MYend
   }
   else	; Relative
   {
      CoordMode, Mouse, Relative
      MouseGetPos, rMXend, rMYend
      If ( rMX > rMXend )
      temp := rMX, rMX := rMXend, rMXend := temp
      If ( rMY > rMYend )
      temp := rMY, rMY := rMYend, rMYend := temp
      Return rMX "|" rMY "|" rMXend "|" rMYend
   }
}
