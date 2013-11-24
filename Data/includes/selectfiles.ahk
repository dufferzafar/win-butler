Build_SelectFiles_Gui:
  Gui, 3:Add, Text,   x5 y7, Filter Text
  Gui, 3:Add, Edit,   x60 y5 w200 h20 vFilter ,
  Gui, 3:Add, Button, x182 y30 w80 h22 gSelectFiles Default, OK
Return

Show_SelectFiles_Gui:
  hWnd := WinExist("A")
  shellApp := ComObjCreate("Shell.Application")
  Gui, 3:Show, w265 Center, Select Files
  ControlSend, Edit1, ^a, Select Files
Return

DeselectAll:
  hWnd := WinExist("A")
  shellApp := ComObjCreate("Shell.Application")

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
      }
    }
  }
Return

SelectFiles:
  Gui, 3:Submit

  If (Filter != "")
  {
    for Item in shellApp.Windows
    {
      If (Item.hwnd = hWnd)
      {
        doc := Item.Document ; ShellFolderView
        ; doc.FilterView(Filter)
        count := doc.Folder.Items.Count
        If(count > 0)
        {
          item := doc.Folder.Items.Item(0)
          doc.SelectItem(item, 4) ; Deselect All
          Loop % count
          {
            item := doc.Folder.Items.Item(A_Index - 1)
            itemPath := item.Path
            SplitPath, itemPath, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
            If InStr(item.Name, Filter) or InStr(OutExtension, Filter)
            {
              doc.SelectItem(item, 1) ; Select Item
            }
          }
        }
      }
    }
  }
Return

3GuiEscape:
3GuiClose:
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
