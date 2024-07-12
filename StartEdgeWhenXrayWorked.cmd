%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
if  not errorlevel 1 (
    start msedge.exe --proxy-server="socks5://127.0.0.1:1080" --user-data-dir=%~dp0chrome-user-data
) else (
    echo There is no edge browser in system, try to install one !!!
    pause
)