/**
 * Focus the navigation pane
 */
Focus:
   If WinActive("ahk_group Explorer_Group")
      ControlFocus, SysTreeView321, ahk_group Explorer_Group
   Else If WinActive("ahk_class HH Parent")
   {
      ; Todo: Focus the Search Controls in the help viewer
      ControlFocus, SysTreeView321, ahk_class HH Parent
      ; ControlSend , SysTreeView321, ^Tab, ahk_class HH Parent
      ; ControlGetFocus, OutputControl, ahk_class HH Parent

      ; Msgbox, % OutputControl
   }
   Else If WinActive("ahk_class classFoxitReader")
      ControlFocus, SysTreeView323, ahk_class classFoxitReader
   Else If WinActive("ahk_class PX_WINDOW_CLASS")
      Send, ^0 ; Focus Sidebar
Return

FocusEsc:
   If WinActive("ahk_group Explorer_Group")
   {
      ControlGetFocus, OutControl, ahk_group Explorer_Group
      ; Msgbox, % OutControl
      If ((OutControl = "SysTreeView321") or (OutControl = "DirectUIHWND1"))
         ControlFocus, DirectUIHWND3, ahk_group Explorer_Group ; The file browser

      Send, {Esc}
   }
   Else If WinActive("ahk_class classFoxitReader")
   {
      ; AfxWnd100su17
      ControlFocus, AfxWnd100su17, ahk_class classFoxitReader
   }
   ; Else If WinActive("ahk_class PX_WINDOW_CLASS")
      ; Send, ^0 ; Focus Sidebar
   Else If WinActive("Buddy List") ; Closes Pidgin. I like it that way...
   {
      Send, !{F4}
   }
   Else
      Send, {Esc}
Return
