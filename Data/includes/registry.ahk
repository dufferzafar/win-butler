; Also deletes the "LastKey". So, basically starts from scratch
RunRegedit:
	RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Policies
	RegDelete, HKCU, Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey

	tmp = %ClipboardAll% 	;save clipboard
	Clipboard := "" 			;clear
	Send, ^c 					;copy the selection
	ClipWait, 1
	Selection = %Clipboard% ;save the selection
	Clipboard = %tmp% 		;restore old content of the clipboard

	If InStr(Selection, "HKEY_")	;if registry key is selected
		RegJump(Selection) 		;Go to Registry path
	Else
		Run Regedit.exe, , Max
Return


;Open Regedit and navigate to RegPath.
;RegPath accepts both HKEY_LOCAL_MACHINE and HKLM formats.
RegJump(RegPath)
{
	;Must close Regedit so that next time it opens the target key is selected
	; WinClose, Registry Editor ahk_class RegEdit_RegEdit

	If (SubStr(RegPath, 0) = "\") ;remove trailing "\" if present
		RegPath := SubStr(RegPath, 1, -1)

	;Extract RootKey part of supplied registry path
	Loop, Parse, RegPath, \
	{
		RootKey := A_LoopField
		Break
	}

	;Now convert RootKey to standard long format
	If !InStr(RootKey, "HKEY_") ;If short form, convert to long form
	{
		If RootKey = HKCR
			StringReplace, RegPath, RegPath, %RootKey%, HKEY_CLASSES_ROOT
		Else If RootKey = HKCU
			StringReplace, RegPath, RegPath, %RootKey%, HKEY_CURRENT_USER
		Else If RootKey = HKLM
			StringReplace, RegPath, RegPath, %RootKey%, HKEY_LOCAL_MACHINE
		Else If RootKey = HKU
			StringReplace, RegPath, RegPath, %RootKey%, HKEY_USERS
		Else If RootKey = HKCC
			StringReplace, RegPath, RegPath, %RootKey%, HKEY_CURRENT_CONFIG
	}

	;Make target key the last selected key, which is the selected key next time Regedit runs
	RegWrite, REG_SZ, HKCU, Software\Microsoft\Windows\CurrentVersion\Applets\Regedit, LastKey, %RegPath%

	Run, Regedit.exe, Max
}