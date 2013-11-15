/**
 * Grab and save screenshots to a folder.
 *
 * Modify global variables to alter behaviour.
 */

GrabScreen:
   sW := A_ScreenWidth, sH := A_ScreenHeight

   Area := 0 "|" 0 "|" sw "|" sH
   FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   Screenshot(Area, Screenshot_Directory, FileName)
Return

GrabScreenSansTaskbar:
   sW := A_ScreenWidth, sH := A_ScreenHeight
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

   Area := 0 "|" 0 "|" sW "|" sH-tbH
   FileName = Screen-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   Screenshot(Area, Screenshot_Directory, FileName)
Return

GrabAndUpload:
   sW := A_ScreenWidth, sH := A_ScreenHeight
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

   Area := 0 "|" 0 "|" sW "|" sH-tbH
   FileName = Temp-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   OutputScreenshot := Screenshot(Area, A_Temp, FileName)
   Response := ImgurUpload(OutputScreenshot)

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

GrabWindow:
   WinGetPos, X, Y, W, H, A
   WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
   sW := A_ScreenWidth, sH := A_ScreenHeight

   Area := (X>0?X:0) "|" (Y>0?Y:0) "|" (W<sW?W:sW) "|" (H<(sH-tbH)?H:(sH-tbH))
   FileName = Window-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

	Screenshot(Area, Screenshot_Directory, FileName)
Return

; Todo: Make this piece of shit work
; GrabArea:
   ; Area := SelectArea("cBlue")
   ; Sleep, 100

   ; FileName = Area-%A_DD%-%A_MMM%-%A_YYYY%-%A_Hour%-%A_Min%-%A_Sec%

   ; Screenshot(Area, Screenshot_Directory, FileName)
; Return

/**
 * Grabs screenshots using GDI+
 *
 * @param {[String]} Area     [The area of the screen to capture] [X|Y|W|H]
 * @param {[String]} FilePath [Full path of the directory where the screenshot will be stored]
 * @param {[String]} FileName [Filename of the resulting screenshot]
 *
 * @returns {[String]} The full file path of the screenshot
 */
Screenshot(Area, FilePath, FileName) {
	Size := 1.0, FileType := "jpg"

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

Base64enc( ByRef OutData, ByRef InData, InDataLen ) {
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, UInt,0, UIntP,TChars, "CDECL Int" )
 VarSetCapacity( OutData, Req := TChars * ( A_IsUnicode ? 2 : 1 ) )
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, Str,OutData, UIntP,Req, "CDECL Int" )
Return TChars
}
