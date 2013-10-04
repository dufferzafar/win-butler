# Windows Butler v1.4

![Butler](/data/butler.png)

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

* *Screenshot* capabilities

  Grab screenshots with ease, just press one of the shortcuts and a screenshot will be saved to your My Pictures folder. You can change the path if you want to.

  * **Printscreen** : Save the entire screen
  * **Shift + Printscreen** : Save a screenshot of the active window

* **Ctrl + Space** : Launch Scriptlet Library

  Take quick notes. Press Ctrl + Space again to save and exit.

  Useful to save random chunks of code/text or whatever.

  Scriptlets can then be executed, saved to file or copied to clipboard.

* **Alt + Ctrl + D** : Select a phrase and then press to find words similar to it via OneLook Reverse Dictionary.

* **Alt + Ctrl + S** : Save selected text

  Select some text and press Alt+Ctrl+S, give a filename and it'll be saved to desktop.

  When no extension is provided, the deafult i.e txt will be used.

* **Ctrl + Shift + S** : Works in *Sublime text*, Press it to launch the currently open file.

  PHP files are opened by the path from localhost.

* **Ctrl + Shift + Esc** : Launch Task manager

  Ever had that nagging "Task Manager has been disabled by your administrator" dialog?

  Worry no more. This hotkey first removes any sort of restriction placed and then launches the task manager. Sweet!

* **Alt + Ctrl + R** : Launch Registry Editor

  Similar to task manager, any restriction on registry editor is removed.

  Also, the "LastKey", which stores the last registry key you accessed is deleted. So you can start afresh.

* **Ctrl + V** in a command prompt window

  It is not possible to paste data directly to a command prompt window. Not anymore. :)

* Disabled

  These hotkeys won't work by default for the simple reason that I do not know where you have your Help files stored. You'll have to tweak the script to provide paths to your help files.

  * **Ctrl + Shift + Q** : Launch Lua's help file.

  * **Ctrl + Shift + A** : Launch Autohotkey's help file.

  * **Ctrl + Shift + Z** : Launch PHP's help file.

## <a name="todo"></a>To Do

* Ask to run on startup.

* Auto Backup

  * Multiple Folders
  * Zip/7Zip. Copy to Dest.
  * Maintain 5 such zips.
  * Filenames should have timestamp.
  * Timer - 15mins or something
  * File/Folder Exclude Patterns (7Zip -x switches) ?

* TrayMenu

  * Turn AutoBackup On/Off
  * Settings GUI
  * About Dialog

* Settings GUI

  * Hotkeys - Bindings, On/Off
  * Folder Paths
  * Backup Settings

* A launcher for some tasks

  * Radial Menu or Sublime like command pallette ?
  * Select text and then play with it: Google, Wiki, WikiQuotes, OneLook.
  * Detect whether the text is url, if so, open it.
  * If the text is larger than 7 words show a save to file action rather than One Look.

* Add other scripts:

  * Renamer
  * Sorting Hat

## <a name="changelog"></a>Changelog

* Explicitly added Gdip.ahk incase it is not present in your standard library.

* **1.4** :

  Added !^d to reverse lookup words on OneLook.

  Added Some naive hotstrings. Like "i'm" gets converted to "I'm" and such.

  Fixed: The Screenshot directory will be created if it doesn't already exist.

  Added: For Markdown (*.md*) files in sublime. Send Alt+M Hotkey which builds the markdown file and opens in browser - I use the MarkdownEditing plugin.

* **1.3** : Added Run from Sublime

* **1.2** : Added Screenshot features

* **1.0** : Initial Release