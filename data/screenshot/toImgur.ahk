#SingleInstance, Force

#Include json.inc.ahk

imgurClient := "a7c30de4f98751b"

File := FileOpen("screen.png", "r")
File.RawRead(Data, File.Length)
Base64enc( PNGDATA, Data, File.Length )

http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
http.Open("POST","https://api.imgur.com/3/upload")
http.SetRequestHeader("Authorization","Client-ID " imgurClient)

SplashTextOn,,,Uploading Image,Please wait...

Sleep, 3000
; http.Send(PNGDATA)
; codes := http.ResponseText
FileRead, codes, Output.json

SplashTextOff


; Msgbox, % codes
Msgbox, % json(codes, "success")
Msgbox, % RegExReplace(json(codes, "data.link"),"\\")
Return

GrabAndUpload:
	Screenshot("Screen-Taskbar")

Return


Base64enc( ByRef OutData, ByRef InData, InDataLen ) {
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, UInt,0, UIntP,TChars, "CDECL Int" )
 VarSetCapacity( OutData, Req := TChars * ( A_IsUnicode ? 2 : 1 ) )
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, Str,OutData, UIntP,Req, "CDECL Int" )
Return TChars
}
