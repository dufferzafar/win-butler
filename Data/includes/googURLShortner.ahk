#Persistent
   LabelEnabled = 1
return

OnClipboardChange:
If (A_EventInfo = 1) & (LabelEnabled) ; IsText
{
   URLRegex = "^(ht|f)tp(s?)://[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(/?)([a-zA-Z0-9-‌​.?,'/\+&;%\$#_]*)?$"

   If RegExMatch(Clipboard, URLRegex) ; IsURL
   {
      If !(InStr(Clipboard, "imgur") or InStr(Clipboard, "goo.gl")) ; Avoid goo.gl and imgur
      {
         Clipboard := Googl(Clipboard) ; Update the clipboard
         Sleep 100
      }
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
