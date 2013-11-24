#Persistent
#SingleInstance Force

Hotkey, IfWinActive, ahk_class CabinetWClass
Hotkey, ^s, SelectFiles_GUI, On
Hotkey, IfWinActive

Gui, 3:Add, Text,   x5 y7, Filter Text
Gui, 3:Add, Edit,   x60 y5 w200 h20 vFilter ,
Gui, 3:Add, Button, x182 y30 w80 h22 gSelectFiles Default, OK
Return

SelectFiles_GUI:
  hWnd := WinExist("A")
  shellApp := ComObjCreate("Shell.Application")

  Filter := ""
  Gui, 3:Show, w265 Center, Select Files
  ; ControlSend, Edit1, ^a
  ; GuiControl,, vFilter, % ""
Return

SelectFiles:
  Gui, 3:Submit

  ; hWnd := WinActive("ahk_class CabinetWClass")

  If (Filter != "")
  {
    for Item in shellApp.Windows
    {
      If (Item.hwnd = hWnd)
      {
        doc := Item.Document ; ShellFolderView
        count := doc.Folder.Items.Count
        If(count > 0)
        {
          item := doc.Folder.Items.Item(0)
          doc.SelectItem(item, 4) ; Deselect All
          Loop % count
          {
            item := doc.Folder.Items.Item(A_Index - 1)
            If InStr(item.Name, Filter)
            {
              doc.SelectItem(item, 1) ; Select Item
            }
          }
        }
      }
    }
  }
Return

Esc::
GuiClose:
  Gui, 3:Cancel
Return


/**
 * 0 = Deselect
 * 1 = Select
 * 3 = Put in edit mode
 * 4 = Deselect all but item
 * 8 = Ensure item is in view
 * 16 = Focus item
 */
