/**
 * If you haven't yet tried XYplorer
 * I urge you to do so for it is quite simply
 * the best File manager I've ever seen.
 */
LaunchXYplorer:
    ; MsgBox, % GetPathFromXYplorer()
    Run, F:\Powerpack\XYplorer\xyplorer.exe "Computer"
Return

/**
 * Get the path of currently open folder
 * in XYplorer.
 *
 * Use Path := (Path = "") ? "C:\" : Path
 * to handle exceptions and set a default path
 */
GetPathFromXYplorer() {
    If WinActive("ahk_class ThunderRT6FormDC")
    {
        SetTitleMatchMode, 2 ; Match title anywhere
        WinGetTitle, Title, A
        RegExMatch(Title, "i)^(.*) - xyplorer", Title)

        If FileExist(Title1)
            Return Title1
        Else If FileExist("C:\Users\" Title1)
            Return "C:\Users\" Title1
        Else
            return ""
    }
    Else
        return ""
}
