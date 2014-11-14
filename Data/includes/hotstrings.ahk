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
   SendInput, {BS} http://dufferzafar.me/
Return

:*:/git::
   SendInput, {BS} http://github.com/dufferzafar/
Return

; BE LAZY
:*:/hah::
   SendInput, {BS} hahahahahaahahahaahahahaahah!
Return

:*:/d1::
   FormatTime, CurrentDate,, d/M/yyyy
   SendInput, %CurrentDate%
Return

:*:/t1::
   FormatTime, CurrentTime,, h:mm tt
   SendInput, %CurrentTime%
Return

; Delhi
:*:/l1::
   SendInput, https://maps.google.com/maps?q=28.6766622`,+77.2705794
Return

; Gurgaon
:*:/l2::
   SendInput, https://maps.google.com/maps?q=28.477770`,+77.018293
Return

:*:/np::
   SendRaw, % """" . nowPlaying(" by ", "") . """"
Return

; Download Now Playing
:*:/dlnp::
   SendRaw, % "https://www.google.co.in/search?q=" . nowPlaying(" by ", "")
Return

; Let Me Google That For You
:*:/lmgtfy::
   SendRaw, http://lmgtfy.com/?q=
Return
