/**
 * Some Dirty Hostrings
 *
 */

; Avoid common grammar mistakes
; ::i::I
::i'd::I'd
::i've::I've
::i'll::I'll
::i'm::I'm

; My Octopress Blog.
:*:/dz::
   SendInput, {BS} dufferzafar.github.com
Return

:*:/gitme::https://github.com/dufferzafar

:*:/d1::
   FormatTime, CurrentDate,, d/M/yyyy
   SendInput, %CurrentDate%
Return

:*:/t1::
   FormatTime, CurrentTime,, h:mm tt
   SendInput, %CurrentTime%
Return

:*:/l1::
   ; Delhi
   SendInput, 28.6766622`,77.2705794
Return

:*:/l2::
   ; Gurgaon
   SendInput, 28.477770`, 77.018293
Return

:*:/np::
   SendInput, % nowPlaying(" by ", "")
Return
