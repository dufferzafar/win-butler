/**
 * Hotkey List
 *
 * ! = Alt
 * ^ = Ctrl
 * + = Shift
 * # = Windows Key
 *
 * Change hotkeys. Turn them On/Off.
 */

Activate_Hotkeys:

   ; CapsLock Be Gone!!
   SetCapsLockState, AlwaysOff

   ; Create a group of windows
   ; Note: Groups are used to club different windows together
   GroupAdd, Explorer_Group, ahk_class CabinetWClass
   GroupAdd, Explorer_Group, ahk_class ExploreWClass

   GroupAdd, Desktop_Group, ahk_class WorkerW
   GroupAdd, Desktop_Group, ahk_class Progman ; for Windows < Vista

   GroupAdd, Taskbar_Group, ahk_class Shell_TrayWnd
   GroupAdd, Taskbar_Group, ahk_class BaseBar
   GroupAdd, Taskbar_Group, ahk_class DV2ControlHost

   GroupAdd, Console_Group, ahk_class ConsoleWindowClass
   GroupAdd, Console_Group, ahk_class Console_2_Main
   GroupAdd, Console_Group, ahk_class VirtualConsoleClass
   GroupAdd, Console_Group, ahk_class PuTTY

   ; Hotkey,   KeyName, Label,         Options

   ; Hotkey,     End,     DoubleTab_End,    Off

   Hotkey,     ^+Esc,   RunTaskMan,       On
   Hotkey,     !^r,     RunRegedit,       On

   Hotkey,     !^d,     OneLook,          On

   Hotkey,     !^s,     SaveText,         On
   Hotkey,     !+s,     SaveRunScript,    On

   Hotkey,     #Space,  RunScriptlet,     On

   ; Hotkey,     ^+q,     HelpPHP,       On
   Hotkey,     ^+q,     HelpPython,       On
   Hotkey,     ^+a,     HelpAHK,          On
   Hotkey,     ^+z,     HelpFolder,       On

   Hotkey,     !^c,     RunCmder,         On
   Hotkey,     !^x,     RunBash,          On

   Hotkey,     $^Esc,   Focus,            On
   Hotkey,     $Esc,    FocusEsc,         On

   ; Hotkey,     #s,      AutoShutsdown,     On

   Hotkey,     #e,      LaunchXYplorer,   On
   Hotkey,     #t,      TopMost,          On
   Hotkey,     #Down,   MinimizeWindow,   On

   Hotkey,     #x,      ShowShareX,       On

   Hotkey,     $^w,      Close,           On
   ; Hotkey,     !F5,     KillWindow,       On

   ; Avoid conflict with the default volume control of VLC
   SetTitleMatchMode, 2 ; Match title anywhere
   Hotkey, IfWinNotActive, VLC media player
   Hotkey,     ^Up,     VolumeUp,         On
   Hotkey,     ^Down,   VolumeDown,       On
   Hotkey, IfWinNotActive

   ; Volume Control
   Hotkey,     WheelUp,   MWheelUp,       On
   Hotkey,     WheelDown, MWheelDown,     On

   ; Run files open in sublime text - <sublime.ahk>
   Hotkey, IfWinActive, ahk_class PX_WINDOW_CLASS  ; Sublime Text 3
   Hotkey,     ^+s,     RunFromSublime,      On
   Hotkey,     !^z,     FolderFromSublime,   Off
   Hotkey, IfWinActive

   ; Extend windows explorer - <explorer.ahk>
   Hotkey, IfWinActive, ahk_group Explorer_Group
   Hotkey,     #q,         ToggleHidden,           On
   Hotkey,     #w,         ToggleExt,              On
   Hotkey,     #f,         FindEverything,         On
   Hotkey,     ^PgDn,      QtTabDn,                On
   Hotkey,     ^PgUp,      QtTabUp,                On
   Hotkey,     !^f,        OpenInSublime,          On
   Hotkey,     ^s,         Show_SelectFiles_Gui,   On
   Hotkey, IfWinActive

   ; Screener Hotkeys - <screenshot.ahk>
   Hotkey,  PrintScreen,   GrabScreen,             On
   Hotkey,  +PrintScreen,  GrabAndUpload,          On
   Hotkey,  ^PrintScreen,  GrabScreenSansTaskbar,  On
   Hotkey,  !PrintScreen,  GrabWindow,             On
   Hotkey,  #LButton,      GrabArea,               On

   ; Launch Journal - <applications.ahk>
   Hotkey,  !^j,           Jrnl,                   On
Return
