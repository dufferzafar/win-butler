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
   Else
   {
      RegExMatch(A_ThisHotkey, "\$(.*)", ThisHotkey)
      Send, % ThisHotkey1
   }
Return

FocusEsc:
   If WinActive("ahk_group Explorer_Group")
   {
      ControlGetFocus, OutControl, ahk_group Explorer_Group
      ; Msgbox, % OutControl
      If (OutControl = "SysTreeView321")
         ControlFocus, DirectUIHWND3, ahk_group Explorer_Group
   }
   Else
   {
      Send, {Esc}
   }
Return
