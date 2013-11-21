#Persistent
return

OnClipboardChange:
If (A_EventInfo = 1)
{
   If RegExMatch(Clipboard, "^(ht|f)tp(s?)://[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(/?)([a-zA-Z0-9-‌​.?,'/\+&;%\$#_]*)?$")
   {
      Msgbox, Hello
   }
}
return

; MsgBox % Googl("http://www.google.co.nz")

Googl(URL)  {
Googl:= ComObjCreate("WinHttp.WinHttpRequest.5.1")
Googl.Open("POST", "https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBXD-RmnD2AKzQcDHGnzZh4humG-7Rpdmg")
Googl.SetRequestHeader("Content-Type", "application/json")
Googl.Send("{""longUrl"": """ URL """}")
Return RegExReplace(Googl.ResponseText,"s).*""id"": ""(.*?)"".*","$1")
}
