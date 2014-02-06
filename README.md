# Windows Butler v3.0

![Butler](/Data/butler.png)

An Autohotkey script to help you with common windows tasks, a life-saver that I just can't live without.

## Table of Contents

* [Usage Instructions](#usage)
* [List of Shortcuts](#hotkeys)
* [Stuff to do](#todo)
* [Changelog](#changelog)

## <a name="usage"></a>Usage Instructions

You'll need to have [Autohotkey](http://l.autohotkey.net/AutoHotkey_L_Install.exe) installed.

Once you have AHK installed, download the [zip](https://github.com/dufferzafar/win-butler/archive/master.zip), extract the contents, and Run WinButler.ahk and be prepared to face some AHK errors.

I created this script for myself and haven't had the time to make it 'user-friendly'. So if don't have prior AHK experience - please delete the Zip file you just downloaded.

Also, Autohotkey has some 'issues' on Windows 8, so it won't work there. The only thing I know is that it works smoooothly for me - Windows 7 x64.

Have fun!

NOTE:

The capslock key's functionality has been disabled in versions greater than 1.8.

Though I know I've done you a [great](http://www.ihatethecapslockkey.com/) favor but if you don't think so, Download the [older version](https://github.com/dufferzafar/win-butler/archive/v1.8.zip) instead.

![The About Gui](/Data/about.jpg)

## <a name="hotkeys"></a>List of Shortcuts

* In windows explorer...

  * **Windows + Q** : Show/Hide hidden files and folders.
  * **Windows + W** : Show/Hide file extensions.

* Screenshot capabilities

  Grab screenshots with ease; press one of the shortcuts and a screenshot will be saved to your My Pictures folder. You can change the path if you want to.

  * **Printscreen** : Save the entire screen.
  * **Shift + Printscreen** : Save the screen, upload to imgur and copy the URL to clipboard like a boss!
  * **Ctrl + Printscreen** : Save the screen but not the taskbar portion.
  * **Alt + Printscreen** : Save the active window.

* **Alt + Ctrl + C** : Launch Cmder in the current directory.

  Launches to root "C:\" if a valid path cannot be grabbed.

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

* Delete Empty Folders

* Paste clipboard as text: Paths
* Task Switcher Hotspot like Preme

* Settings GUI
  * Folder Paths
  * Screenshot
  * Backup
  * Hotkeys - Bindings, On/Off

* Ensure ManicTime and Networx are always running.

* Auto-Commit every x minutes
  * Similar to backup buddy.

* Screenshots
  * Upload any image via Traymenu
  * Add Shift to upload in all

## <a name="changelog"></a>Changelog

* Updated: Startup applications only run if not already running.
* Added: Delays some applications so as to reduce load on startup. <applications.ahk>
* Added: A check to ensure that some required applications are always running. See <applications.ahk>
* Updated: All Urls and HTML files now open in Firefox.

* **3.0**

  * Updated: Volume OSD shows both Song and Artist.
  * Updated: Ctrl+Esc focuses the sidebars in _some_ programs. See <includes/focus.ahk>

  * Added: Alt + Ctrl + X - Launch Bash Shell here (but in Cmder).
  * Updated: Cmder overhaul.

  * Remapped a few hotkeys.
  * Windows + F - Launches Everything search in the current folder.
  * Added: Alt + Ctrl + Z - Launches the currently opened file's folder from sublime. This hotkey is off by default, as I use a [Sublime Plugin](https://github.com/dufferzafar/homepages/python-scripts/Sublime%20Text%203%20Plugins/
  ) to open the project/file folder. 

* **2.8**:

  * Modified: Alt + Ctrl + C - Now launches Cmder instead of Console2.
  * Removed: All other hacky command prompt improvements as they seem childish infront of the power of cmder.
  * Removed: RunGitShell. Use Cmder instead.

  * Created a separate file to log all the wild ideas that come to mind. Later.md

  * Added: Ctrl + W - Maps to Alt + F4 in some applications.
  * Added: Backup Buddy. Modify settings in <buddy\backup.ahk>.

  * Added: Shows the currently playing song in Volume OSD. Works because I have Windows Media Player Plus! plugin enabled. Get it from http://www.bm-productions.tk/

* **2.7**:

  * Backup Buddy added. NOT activated though.
  
  * Added: Ctrl + Esc - Sets focus to navigation pane in Windows Explorer.
  * Updated: RestartExplorer. Now uses a function by SKAN.
  * Updated: Help files are now SingleInstance <run.ahk>
  * Minor Tweaks in <console.ahk>
  * Added: Mouse wheel up/down over taskbar - Adjust audio volume.
  * Bugfix: RunRegedit now launches the selected key properly.

* **2.6**:

  * Miscellaneous improvements in <explorer.ahk>
  * Added: Ctrl + Windows + E - Restart Shell.
  * Modified: GetCurrentFolderPath() to use ShellFolderView. Far better method.
  * Removed: Console2 has been removed from the package, download seperately and put it in Data/console2/. This reduces the size of the repo by 1 MB :)

* **2.5**:

  * Refactored: Broke the code into more different files.

  * Added: Alt + Ctrl + X - Launch Git Shell in current directory.
  * Refactored: Selectfiles. Leaner Code.
  * Added: Ctrl + S - Select multiple files in explorer. 
  * Fixed: Ctrl+Up/Down - Doesn't mess with VLC's default volume control.
  * Added: PgUp, PgDn - Scrolling in any console window.
  * Added: Date/Time Hotstrings.

* **2.3**:

  * Added: An About Gui. yay!
  * Added: TrayMenu Icons for changing the screenshot size.
  * Added: TrayIcon for when the script is suspended. 

* **2.1**:

  * Added: Ctrl + Up/Down - Volume Control (On Screen Display).

  * Enabled: SelectArea. Bug Fixed.
  * Modified: Windows + Space instead of Ctrl + Space - Opens Scriptlet Library.

* **2.0**:

  * Added: Shift + Printscreen - Upload screenshots to Imgur 

  * Refactored: Screenshot.ahk
  * Disabled: SelectArea Screenshot (not reliable)
  * Added Windows + LButton to grab screen area.

  * Added: Alt + Shift + S - Save and Run AHK Scripts
  * Modified: Minor improvements to SaveScript:

  * Modified: Windows + Down - Minimizes instead of restoring.

  * Added: Windows + S - Autoshutdown in X minutes.
  * Updated: Multiple files can be opened in sublime from explorer.
  * Added: Ctrl + PgDn/PgUp - QtTabBar Improvements. 
  * Added: ALt + Ctrl + F - Opens the selected file in sublime text.
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

  * Modified: Ctrl + Shift + Z - to open Help Folder instead of PHP.
  * Added: Alt + Ctrl + C - to launch Console2
  * Added: Ctrl + W - closes the Command Prompt.
  * Added: Ctrl + N - to create a new file in folder.

  * Added Gdip.ahk incase it is not present in your standard library.

* **1.4** :

  * Added: Alt + Ctrl + D to reverse lookup words on OneLook.
  * Added: Some naive hotstrings. Like "i'm" gets converted to "I'm" and such.
  * Fixed: The Screenshot directory will be created if it doesn't already exist.

  * Added: For Markdown (*.md*) files in sublime. Send Alt+M Hotkey which builds the markdown file and opens in browser - I use the MarkdownEditing plugin.

* **1.3** : Added Run from Sublime

* **1.2** : Added Screenshot features

* **1.0** : Initial Release

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dufferzafar/win-butler/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

