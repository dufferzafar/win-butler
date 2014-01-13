/**
 * Grab and save screenshots to a folder.
 *
 * Modify global variables to alter behaviour.
 */

; Todo: Easier way to share links after some time.

GrabArea:
   RawArea := SelectArea()
   StringSplit, AreaArr, RawArea, |

   Area := AreaArr1 "|" AreaArr2 "|" AreaArr3-AreaArr1 "|" AreaArr4-AreaArr2

   FileName = Area-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   ; Msgbox, % Area
   Screenshot(Screenshot_Size, Area, Screenshot_Directory, FileName)
Return

GrabScreen:
   sW := A_ScreenWidth, sH := A_ScreenHeight

   Area := 0 "|" 0 "|" sw "|" sH
   FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   Screenshot(Screenshot_Size, Area, Screenshot_Directory, FileName)
Return

GrabScreenSansTaskbar:
   sW := A_ScreenWidth, sH := A_ScreenHeight
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

   Area := 0 "|" 0 "|" sW "|" sH-tbH
   FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   Screenshot(Screenshot_Size, Area, Screenshot_Directory, FileName)
Return

GrabAndUpload:
   sW := A_ScreenWidth, sH := A_ScreenHeight
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

   Area := 0 "|" 0 "|" sW "|" sH
   FileName = Temp-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   OutputScreenshot := Screenshot(Screenshot_Size, Area, A_Temp, FileName)
   Response := ImgurUpload(OutputScreenshot)
   ; Msgbox, % Response
   If (json(Response, "success"))
   {
      Clipboard := RegExReplace(json(Response, "data.link"),"\\")

      SplitPath, OutputScreenshot,,, OutExtension
      FileMove, % OutputScreenshot, % Imgur_Directory "\" json(Response, "data.id") "." OutExtension

      FileAppend, % Response, % Imgur_Directory "\ImgurData\" json(Response, "data.id") ".json"

; Let the user know we have started
TrayTip, Windows Butler %Version%,
(
URL Copied to Clipboard

%Clipboard%
)
SetTimer, RemoveTrayTip, 5000
   }
   Else
   {
      Msgbox, An Error Occured
      FileDelete, % OutputScreenshot
   }
Return

GrabWindow:
   WinGetPos, X, Y, W, H, A
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
   sW := A_ScreenWidth, sH := A_ScreenHeight

   Area := (X>0?X:0) "|" (Y>0?Y:0) "|" (W<sW?W:sW) "|" (H<(sH-tbH)?H:(sH-tbH))
   FileName = Window-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

	Screenshot(Screenshot_Size, Area, Screenshot_Directory, FileName)
Return

/**
 * Grabs screenshots using GDI+
 *
 * @param {[String]} Area     [The area of the screen to capture] [X|Y|W|H]
 * @param {[String]} FilePath [Full path of the directory where the screenshot will be stored]
 * @param {[String]} FileName [Filename of the resulting screenshot]
 *
 * @returns {[String]} The full file path of the screenshot
 */
Screenshot(Size, Area, FilePath, FileName) {
	FileType := "jpg"

   ; Grab Screen
	pBitmap := Gdip_BitmapFromScreen(Area)

	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	PBitmapResized := Gdip_CreateBitmap(Round(Width*Size), Round(Height*Size))

	G := Gdip_GraphicsFromImage(pBitmapResized), Gdip_SetInterpolationMode(G, 7)
	Gdip_DrawImage(G, pBitmap, 0, 0, Round(Width*Size), Round(Height*Size), 0, 0, Width, Height)

	Gdip_SaveBitmapToFile(PBitmapResized, FilePath "\" FileName "." FileType)

   ; Cleanup
	Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapResized), Gdip_DisposeImage(pBitmap)

   Return FilePath "\" FileName "." FileType
}

ImgurUpload(ImagePath) {
   imgurClient := "a7c30de4f98751b"

   File := FileOpen(ImagePath, "r")
   File.RawRead(Data, File.Length)
   Base64enc( PNGDATA, Data, File.Length )

   http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   http.Open("POST","https://api.imgur.com/3/upload")
   http.SetRequestHeader("Authorization","Client-ID " imgurClient)

   http.Send(PNGDATA)
   Return http.ResponseText
}

Base64enc( ByRef OutData, ByRef InData, InDataLen ) { ; SKAN
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, UInt,0, UIntP,TChars, "CDECL Int" )
 VarSetCapacity( OutData, Req := TChars * ( A_IsUnicode ? 2 : 1 ) )
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, Str,OutData, UIntP,Req, "CDECL Int" )
Return TChars
}

SelectArea(Options="") {   ; by Learning one
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
   if m = s ; Screen
   {
      MouseGetPos, MXend, MYend
      If ( MX > MXend )
      temp := MX, MX := MXend, MXend := temp
      If ( MY > MYend )
      temp := MY, MY := MYend, MYend := temp
      Return MX "|" MY "|" MXend "|" MYend
   }
   else  ; Relative
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
