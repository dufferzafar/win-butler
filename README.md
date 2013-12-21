# Windows Butler v2.6

![Butler](/Data/butler.png)

An Autohotkey script to help you with common windows tasks, a life-saver that I just can't live without.

## Table of Contents

* [Usage Instructions](#usage)
* [List of Shortcuts](#hotkeys)
* [Stuff to do](#todo)
* [Could be added later](#later)
* [Changelog](#changelog)

## <a name="usage"></a>Usage Instructions

You'll need to have [Autohotkey](http://l.autohotkey.net/AutoHotkey_L_Install.exe) installed.

Once you have AHK installed, download the [zip](https://github.com/dufferzafar/win-butler/archive/master.zip), extract the contents, and Run WinButler.ahk

Have fun!

NOTE:

The capslock key's functionality has been disabled in versions greater than 1.8.

Though I know I've done you a [great](http://www.ihatethecapslockkey.com/) favor but if you don't think so, Download the [older version](https://github.com/dufferzafar/win-butler/archive/v1.8.zip) instead.

![The About Gui](/Data/about.jpg)

## <a name="hotkeys"></a>List of Shortcuts

* In windows explorer...

  * **Windows + J** : Show/Hide hidden files and folders.
  * **Windows + Y** : Show/Hide file extensions.

* Screenshot capabilities

  Grab screenshots with ease; press one of the shortcuts and a screenshot will be saved to your My Pictures folder. You can change the path if you want to.

  * **Printscreen** : Save the entire screen.
  * **Shift + Printscreen** : Save the screen, upload to imgur and copy the URL to clipboard like a boss!
  * **Ctrl + Printscreen** : Save the screen but not the taskbar portion.
  * **Alt + Printscreen** : Save the active window.

* **Alt + Ctrl + C** : Launch Console in the current directory.

  Launches to root "C:\" if path cannot be grabbed.

* **Windows + Space** : Launch Scriptlet Library

  Take quick notes. Press Windows + Space again to save and exit.

  Useful to save random chunks of code/text or whatever.

  Scriptlets can be executed, saved to file or copied to clipboard.

* **Alt + Ctrl + D** : Select a phrase and then press the hotkey to find words similar to it via the OneLook Reverse Dictionary.

* **Alt + Ctrl + S** : Save selected text

  Select some text and press Alt+Ctrl+S, give a filename and it'll be saved to desktop. When no extension is provided, the deafult i.e txt will be used.

* **Alt + Shift + S** : Save selected text as AHK and execute the Script

* **Ctrl + Shift + S** : Works in *Sublime text*, Press it to launch the currently open file. PHP files are opened by the path from localhost.

* **Ctrl + Shift + Esc** : Launch Task manager

  This hotkey first removes any sort of restriction placed (like "Taskmanager has been disabled by your administrator").

* **Alt + Ctrl + R** : Launch Registry Editor

  Select a registry key like "HKEY_CLASSES_ROOT\Python.File\shell\open" and then Press the hotkey to directly jump to that Key. Sweet, ain't it?

  Similar to task manager, any restriction on registry editor is removed.

* In a Command prompt window

  * **Ctrl + V**: It is not possible to paste data directly to a command prompt window. Not anymore.

  * **Ctrl + W**: Close the console.

* Launch CHM Help files...

  You'll have to tweak the script to provide paths to your help files.

  * **Ctrl + Shift + Q** : Launch Python's help file.
  * **Ctrl + Shift + A** : Launch Autohotkey's help file.
  * **Ctrl + Shift + Z** : Launch Help Folder

## <a name="todo"></a>To Do ASAP

* Volumouse: http://www.nirsoft.net/utils/volumouse.html
* BugShooting: http://www.bugshooting.com/

* Ensure ManicTime and Networx are running always.

* Favorite folders 
  * Middle Click Menu | Hotkey ?
  * JnLnd's Fav Folder Script
  * Sublime's Folder

* Clipboard History?

* Volume Control
  * Better Gui
  * Bottom Right Corner
  * CurrentSong in WMP
  * Mute/Unmute

* Select Files
  * Handle extensions
  * Regex

* Run last run script !+s.

## <a name="later"></a>Could be added later

* Features from 7Plus: (Filter on accounts of usability)
  [] Make Backspace go upwards
  [X] Select files by entering a file filter such as ".jpg"
  [X] Kill programs by pressing ALT+F5 or right clicking the close button
  [] Automatically select first file when you enter a directory
  [] Copy filenames (ALT+C) and paths (CTRL+ALT+C)
  [] Set windows to be "Always on top" by right clicking the title bar
  [X] Adjust audio volume with mouse wheel up/down over taskbar
  [] Store favorite folders and recall them
  [] Create new folders and textfiles. F8/F7.
  [] Paste text or image from clipboard as file
  [] Open any file in your favorite text/image editor. F3.
  [] Advanced Renaming and Replacing in files
  [] Paste previous clipboard text entries by pressing WIN+V
  [] Rotate images in Windows Picture Viewer by pressing R and L

* Other Scripts
  * Backup Buddy. Animated TrayIcon.
  * Core part of Sorting Hat.
  * Renamer

* Screenshots
  * Add Shift to upload in all...

* Settings GUI
  * Folder Paths
  * Screenshot
  * Backup
  * Hotkeys - Bindings, On/Off

* Imgur User Account
  * Authorization Headers

* Hotstrings
  * Date/Time
  * Address, State, ZipCode
  * Emails
  * WebURLs

* Goo.gl URL Shortner
  * OnClipboardChange ?
  * On Ctrl+V if IsURL()
  * Authorization Headers

* Global Ctrl + W
  * WhiteList/BlackList
  * Maps to Alt+F4
  * But in some applications to Ctrl+W

## <a name="changelog"></a>Changelog

* Added: Adjust audio volume with mouse wheel up/down over taskbar.

* Bugfix: RunRegedit now launches the selected key properly.

* **2.6**:

  * Miscellaneous improvements in <explorer.ahk>
  * Added: Restart Shell. Ctrl + Windows + E.
  * Modified: GetCurrentFolderPath() to use ShellFolderView. Far better method.
  * Removed: Console2 has been removed from the package, download seperately and put it in Data/console2/. This reduces the size of the repo by 1 MB :)

* **2.5**:

  * Refactored: Broke the code into more different files.

  * Refactored: Selectfiles. Leaner Code.
  * Added: Select multiple files in explorer. Ctrl + S.
  * Fixed: Ctrl+Up, Ctrl+Down now don't mess with VLC's default volume control.
  * Added: PgUp, PgDn Scrolling in any console window.
  * Added: Date/Time Hotstrings.

* **2.3**:

  * Added: An About Gui. yay!
  * Added: TrayMenu Icons for changing the screenshot size.
  * Added: TrayIcon for when the script is suspended. 

* **2.1**:

  * Added: Volume Control (On Screen Display). Ctrl+Up. Ctrl+Down.

  * Enabled: SelectArea. Bug Fixed :)
  * Modified: Scriptlet Library opens with Windows+Space instead of Ctrl+Space.

* **2.0**:

  * Added: GrabAndUpload - Upload screenshots to Imgur (Shift + Printscreen)

  * Refactored: Screenshot.ahk
  * Disabled: SelectArea Screenshot (not reliable)
  * Added Windows + LButton to grab screen area.

  * Added: Alt+Shift+S - Save and Run AHK Scripts
  * Modified: Minor improvements to SaveScript:

  * Modified: Windows+Down minimizes instead of restoring.

  * Added: Windows+S - Autoshutdown in X minutes.
  * Updated: Multiple files can be opened in sublime from explorer.
  * Added: QtTabBar Improvements. Ctrl+PgDn, Ctrl+PgUp.
  * Added: ALt+Ctrl+F Opens the selected file in sublime text.
  * Remapped: CapsLock to Backspace.

* **1.8**:

  * Removed: Ctrl + N (New File) Hotkey. Useless.

  * Modified: Printscreen now captures the screen but avoids the sidebar. Use Shift+Printscreen to capture the entirety, and Ctrl+Printscreen to capture Active Windows.

  * Modified: Alt+Ctrl+C - Runs Console2 instead of CommandPrompt.

  New Modules:
    * AutoShutdown
    * Volume OSD

  Refactored into Modules:
    * Run from Sublime
    * Screennshot
    * Registry
    * Explorer

  * Added: RegJump - Jumps to a specified registry key

* **1.5**:

  * Modified: Ctrl+Shift+Z to open Help Folder instead of PHP.
  * Added: Alt+Ctrl+C to launch Console2
  * Added: Ctrl+W closes the Command Prompt.
  * Added: Ctrl+N to create a new file in folder.

  * Added Gdip.ahk incase it is not present in your standard library.

* **1.4** :

  * Added: Alt+Ctrl+D to reverse lookup words on OneLook.
  * Added: Some naive hotstrings. Like "i'm" gets converted to "I'm" and such.
  * Fixed: The Screenshot directory will be created if it doesn't already exist.

  * Added: For Markdown (*.md*) files in sublime. Send Alt+M Hotkey which builds the markdown file and opens in browser - I use the MarkdownEditing plugin.

* **1.3** : Added Run from Sublime

* **1.2** : Added Screenshot features

* **1.0** : Initial Release

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dufferzafar/win-butler/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

