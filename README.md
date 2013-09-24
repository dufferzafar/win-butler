# Windows Butler

An Autohotkey script to help you with common windows tasks.

It is a compilation of some of my scripts: WinHelper, Screener, Scriptlet Library.

## Table of Contents

* [Usage Instructions](#usage-instructions)
* [List of Hotkeys](#hotkeys)
* [Stuff to do](#todo)

## <a name="usage-instructions"></a>Usage Instructions

You'll need to have [Autohotkey](http://www.autohotkey.com/) installed.

Just do it, if you already haven't, you'll be needing it for most of my stuff.

Once you have AHK ready, download the [zip](https://github.com/dufferzafar/win-butler/archive/master.zip),
extract the contents, and Run WinButler.ahk

Have fun!

## <a name="hotkeys"></a>List of Hotkeys

* In windows explorer

  * Windows + C : Launch command prompt in the current directory.
  * Windows + J : Show/Hide hidden files and folders.
  * Windows + Y : Show/Hide file extensions.

* Ctrl + Space : Launch Scriptlet Library

  Take quick notes. Press Ctrl + Space again to save and exit.

  Useful to save random chunks of code.

  Scriptlets can then be executed, saved to file or copied to clipboard.

* Alt + Ctrl + S : Save selected text

  Select some text and press Alt+Ctrl+S, give a filename and it'll be saved to desktop.

* Ctrl + Shift + Esc : Launch Task manager

  Ever had that nagging "Task Manager has been disabled by your administrator" dialog?

  Worry no more. This hotkey first removes any sort of restriction placed and then launches the task manager. Sweet!

* Alt + Ctrl + R : Launch Registry Editor

  Similar to task manager, any restriction on registry editor is removed.

  Also, the "LastKey", which stores the last registry key you accessed is deleted. So you can start afresh.
  You can change this behaviour, if that suits you.

* Ctrl + V in a command prompt window

  It is not possible to paste data directly to a command prompt window. Not anymore. :)

* Disabled

  These hotkeys are disabled by default. You'll have to tweak the file to enable them.

  * Ctrl + Shift + Q : Launch Lua's help file.

  * Ctrl + Shift + A : Launch Autohotkey's help file.

  * Ctrl + Shift + Z : Launch PHP's help file.

## <a name="todo"></a>To Do

* Edit Hotkeys, Settings, About GUI.

* Add Screenshot Functions from Screener

* Try to add Renamer features too.