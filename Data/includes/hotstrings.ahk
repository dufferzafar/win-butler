/**
 * Some Dirty Hostrings
 *
 */

; Avoid common grammar mistakes
::i::I
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
