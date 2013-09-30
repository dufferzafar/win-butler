# Windows Butler v1.3

![](data\butler.png)

An Autohotkey script to help you with common windows tasks.

It is a compilation of some scripts: WinHelper, Screener, Scriptlet Library.

## Table of Contents

* [Usage Instructions](#usage-instructions)
* [List of Shortcuts](#hotkeys)
* [Stuff to do](#todo)
* [Changelog](#changelog)

## <a name="usage-instructions"></a>Usage Instructions

You'll need to have [Autohotkey](http://l.autohotkey.net/AutoHotkey_L_Install.exe) installed.

Just do it, if you already haven't, you'll be needing it for most of my stuff.

Once you have AHK installed, download the [zip](https://github.com/dufferzafar/win-butler/archive/master.zip),
extract the contents, and Run WinButler.ahk

Have fun!

## <a name="hotkeys"></a>List of Shortcuts

* In windows explorer press these for the desired action

  * **Windows + C** : Launch command prompt in the current directory.
  * **Windows + J** : Show/Hide hidden files and folders.
  * **Windows + Y** : Show/Hide file extensions.

* Screenshot capabilities

  Grab screenshots with ease, just press one of the shortcuts and a screenshot will be saved to
  your My Pictures folder. You can change the path if you want to.

  * **Printscreen** : Save the entire screen
  * **Shift + Printscreen** : Save a screenshot of the active window

* **Ctrl + Space** : Launch Scriptlet Library

  Take quick notes. Press Ctrl + Space again to save and exit.

  Useful to save random chunks of code/text or whatever.

  Scriptlets can then be executed, saved to file or copied to clipboard.

* **Alt + Ctrl + S** : Save selected text

  Select some text and press Alt+Ctrl+S, give a filename and it'll be saved to desktop.

  When no extension is provided, the deafult i.e txt will be used.

* In Sublime text, Press **Ctrl + Shift + S** to launch the currently open file

  PHP files are opened by the path from localhost.

* **Ctrl + Shift + Esc** : Launch Task manager

  Ever had that nagging "Task Manager has been disabled by your administrator" dialog?

  Worry no more. This hotkey first removes any sort of restriction placed and then launches the task manager. Sweet!

* **Alt + Ctrl + R** : Launch Registry Editor

  Similar to task manager, any restriction on registry editor is removed.

  Also, the "LastKey", which stores the last registry key you accessed is deleted. So you can start afresh.
  You can change this behaviour, if that suits you.

* **Ctrl + V** in a command prompt window

  It is not possible to paste data directly to a command prompt window. Not anymore. :)

* Disabled

  These hotkeys are disabled by default. You'll have to tweak the file to enable them.

  * **Ctrl + Shift + Q** : Launch Lua's help file.

  * **Ctrl + Shift + A** : Launch Autohotkey's help file.

  * **Ctrl + Shift + Z** : Launch PHP's help file.

## <a name="todo"></a>To Do

* Ask to run on startup.

* Edit Hotkeys, Settings, About GUI.

* Add other scripts:

  * Renamer
  * Sorting Hat

## <a name="changelog"></a>Changelog

* **1.3** : Added Run from Sublime

* **1.2** : Added Screenshot features

* **1.0** : Initial Release