^+v::
   StringReplace, clipboard, clipboard, `r`n, `n, All
   Sleep 100
   ; Send, ^v
   SendInput, %clipboard%
Return
