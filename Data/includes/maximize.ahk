/**
 * Toggle Visibility of the Titlebar
 *
 * Credits: @GeekDude from #ahk
 */
ToggleTitleBar:
    WinActive("A")
    WinGet, winId, ID

    if (TitleBarHidden_%winId% = True)
    {
        WinSet, Style, % "+" 0xC00000, A    ; WS_CAPTION
        TitleBarHidden_%winId% = 0
    }
    else
    {
        WinSet, Style, % "-" 0xC00000, A    ; WS_CAPTION
        TitleBarHidden_%winId% = 1
    }
Return
