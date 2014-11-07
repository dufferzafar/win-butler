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

   SetTitleMatchMode, 2 ; Match title anywhere
   GroupAdd, VolumeOSD_Blacklist, VLC media player
   GroupAdd, VolumeOSD_Blacklist, ahk_class gdkWindowToplevel

   ; Hotkey,   KeyName, Label,         Options

   ; Hotkey,     End,     DoubleTab_End,    Off

   Hotkey,     ^+Esc,   RunTaskMan,       On
   Hotkey,     !^r,     RunRegedit,       On

   Hotkey,     !^d,     OneLook,          On

   Hotkey,     !^s,     SaveText,         Off
   Hotkey,     !+s,     SaveRunScript,    Off

   Hotkey,     #Space,  RunScriptlet,     On

   Hotkey,     ^+q,     HelpPython,       On
   Hotkey,     ^+a,     HelpAHK,          On
   Hotkey,     ^+z,     HelpFolder,       On

   Hotkey,     !^c,     RunCmder,         On
   Hotkey,     !^x,     RunBash,          On

   Hotkey,     $^Esc,   Focus,            On
   Hotkey,     $Esc,    FocusEsc,         On

   Hotkey,     #s,      AutoShutdown,     Off

   Hotkey,     #e,      LaunchXYplorer,   On
   Hotkey,     #t,      TopMost,          On
   Hotkey,     #Down,   MinimizeWindow,   On

   Hotkey,     #x,      ShowShareX,       On

   Hotkey,     $^w,      Close,           On
   Hotkey,     !F5,     KillWindow,       Off

   Hotkey,     #F12,    ToggleCursor,     On

   ; Disable VolumeOSD in some applications
   Hotkey, IfWinNotActive, ahk_group VolumeOSD_Blacklist
   Hotkey,     $^Up,     VolumeUp,         On
   Hotkey,     $^Down,   VolumeDown,       On
   Hotkey, IfWinNotActive

   ; Volume Control
   Hotkey,     WheelUp,   MWheelUp,       Off
   Hotkey,     WheelDown, MWheelDown,     Off

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

   ; XYplorer
   Hotkey, IfWinActive, ahk_class ThunderRT6FormDC
   Hotkey,     #f,         FindEverything,         On
   Hotkey, IfWinActive

   ; Launch Journal - <applications.ahk>
   Hotkey,  !^j,           Jrnl,                   On

   ; Pidgin message history - <WinButler.ahk>
   Hotkey, IfWinActive, ahk_class gdkWindowToplevel
   Hotkey,     !Left,     PidginHistoryUp,           On
   Hotkey,     !Right,    PidginHistoryDown,         On
   Hotkey, IfWinActive
Return
