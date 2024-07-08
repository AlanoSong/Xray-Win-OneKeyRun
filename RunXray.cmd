@echo off
cls

:: Run as admin
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
CD /D "%~dp0"

echo Update IP firstly ???
choice /C 12 /T 15 /D 2 /M "1.[Update config] 2.[Run directly]"
if errorlevel 2 goto StartRun
if errorlevel 1 goto UpdateWithSvr1

:: Try to get latest config file one by one
:UpdateWithSvr1
.\wget\wget -t 2 --no-check-certificate https://www.gitlabip.xyz/Alvin9999/pac2/master/xray/1/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://gitlab.com/free9999/ipupdate/-/raw/master/xray/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://www.githubip.xyz/Alvin9999/pac2/master/xray/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://fastly.jsdelivr.net/gh/Alvin9999/pac2@latest/xray/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://www.gitlabip.xyz/Alvin9999/pac2/master/xray/3/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://gitlab.com/free9999/ipupdate/-/raw/master/xray/2/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://www.githubip.xyz/Alvin9999/pac2/master/xray/2/config.json
if exist config.json goto ConfigCopy
.\wget\wget -t 2 --no-check-certificate https://fastly.jsdelivr.net/gh/Alvin9999/pac2@latest/clash/2/config.json
if exist config.json goto ConfigCopy
:: Get config file failed, exit directly
echo Update IP failed, add more valid server
pause
exit

:ConfigCopy
pause
copy /y "%~dp0config.json" %~dp0XRay\config.json
del "%~dp0config.json"
goto StartRun

:StartRun

start "" "%~dp0Xray\xray.exe"  -c .\Xray\config.json
%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
if  not errorlevel 1 (
    start msedge.exe --proxy-server="socks5://127.0.0.1:1080" --user-data-dir=%~dp0chrome-user-data
) else (
    echo There is no edge browser in system, try to install one !!!
    pause
)