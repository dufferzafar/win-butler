/**
 * Scriptlet Library
 *
 * Make sure the additional ahk exists.
 */
RunScriptlet:
   IfWinExist, My Scriptlet Library
   {
      PostMessage, 0x112, 0xF060,,, My Scriptlet Library
   }
   Else
   {
      ScriptletPath := A_ScriptDir . "\Data\scriptLib\Scriptlet Library.ahk"
      SplitPath, ScriptletPath,,ScriptletDir
      Run, %ScriptletPath%, %ScriptletDir%
   }
Return

/**
 * Run Task Manager
 *
 * Applications are run after removing any administrator restrictions (usually caused by viruses)
 */
RunTaskMan:
   RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Policies
   RegDelete, HKCU, Software\Microsoft\Windows NT\CurrentVersion\TaskManager

   RegDelete, HKLM, Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

   RegDelete, HKLM, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon, DisableCAD
   RegDelete, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, DisableTaskMgr

   Run Taskmgr.exe
Return

/**
 * Launch Help Files
 *
 * Make sure the paths are correct
 */
HelpAHK:
   SplitPath, A_AhkPath,, ahk_dir

   If wnd := WinExist("AutoHotkey_L Help")
      WinActivate, ahk_id %wnd%
   Else
      Run, %ahk_dir%\AutoHotkey.chm, , Max
Return

HelpLUA:
   If wnd := WinExist("Lua AIO")
      WinActivate, ahk_id %wnd%
   Else
      Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\Lua AIO.chm", , Max
Return

HelpPython:
   If wnd := WinExist("Python v3.3.0 documentation")
      WinActivate, ahk_id %wnd%
   Else
      Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\Python 330.chm", , Max
Return

HelpPHP:
   Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]\php.chm", , Max
Return

HelpFolder:
   Run, % "D:\I, Coder\Scripts, Codes & Tut\[Help]"
Return
