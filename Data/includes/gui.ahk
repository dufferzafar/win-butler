Build_MainGui:
Gui, 1:Add, Tab2, x-1 y0 h500 w480, About

Gui, 1:Tab,About
   Gui, 1:Add, Picture, Section x7 y30, Data\gui\Butler-Logo.png

   Gui, 1:Font, s10, Verdana
   Gui, 1:Add, Text, x8 y140, Written in
   Gui, 1:Add, Text, x277 y140, Completely
   Gui, 1:Add, Text, x427 y140, Code

   Gui, 1:Add, Text, x8 y180, Depends on the following:
   Gui, 1:Add, Text, xp+10 y+5, 'Gdip' by tic
   Gui, 1:Add, Text, xp y+5, 'json' by polyethene
   Gui, 1:Add, Text, xp y+5, 'SelectArea' by LearningOne
   Gui, 1:Add, Text, xp y+5, 'Base64enc' by SKAN
   Gui, 1:Add, Text, xp y+5, 'Scriptlet Library' by Rajat, toralf
   Gui, 1:Add, Text, xp y+5, 'Vista Audio (VA)' by Lexikos

   Gui, 1:Add, Text, xs+2 y+15, Special thanks to these awesome people, especially to Chris Mallet
   Gui, 1:Add, Text, xp y+5,  for creating Autohotkey and to Lexikos for taking it further with _L

   Gui, 1:Add, Text, x362 y+40, by
   Gui, 1:Font, CBlue
   Gui, 1:Add, Text, x385 yp gGui_Link_Handler, dufferzafar
   Gui, 1:Add, Text, x200 y+5 gGui_Link_Handler, http://dufferzafar.github.io/win-butler/

   Gui, 1:Font, CBlack
   Gui, 1:Add, Text, xs yp-20 Disabled, Version - %Version%
   Gui, 1:Add, Text, xp y+5 Disabled, Released On - %Version_Date%

   ; Gui, 1:Font, Strike
   Gui, 1:Font, CBlue
   Gui, 1:Add, Text, x80  y140 gGui_Link_Handler, Autohotkey
   Gui, 1:Add, Text, x353 y140 gGui_Link_Handler, Unlicensed

   Gui, 1:Font

   ; Load the hand cursor.
   hCurs := DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND

   ; Used by the main gui to show hand cursor
   OnMessage(0x200,"WM_MOUSEMOVE")
Return

ShowGui:
   ;Show Main Gui
   ; Gui, +LastFound
   Gui, 1:Show, h470 w472 Center, Windows Butler
   ; mainGuiID := WinExist()
Return

GuiClose:
   Gui, 1:Cancel
Return

Gui_Link_Handler:
   If (A_GuiControl = "AutoHotkey")
      Run, http://www.autohotkey.com/,, UseErrorLevel
   Else If (A_GuiControl = "Unlicensed")
      Run, http://www.unlicense.org/,, UseErrorLevel
   Else If (A_GuiControl = "dufferzafar")
      Run, http://www.github.com/dufferzafar/,, UseErrorLevel
   Else If (A_GuiControl = "http://dufferzafar.github.io/win-butler/")
      Run, http://dufferzafar.github.io/win-butler/,, UseErrorLevel
Return

WM_MOUSEMOVE(wParam,lParam)
{
   Global hCurs
   MouseGetPos,,,,Ctrl
   ControlGetText, CtrlText, % Ctrl
   If CtrlText in AutoHotkey,Unlicensed,dufferzafar
      DllCall("SetCursor","UInt",hCurs)
   Else If (CtrlText = "http://dufferzafar.github.io/win-butler/")
      DllCall("SetCursor","UInt",hCurs)
   Return
}
