@echo OFF
title [25Assist] Download from AAO25.com  v0.1 ::Possessed::
color 5E
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
cd %APPDATA%\25Assist
if exist "C:\users\%username%\appdata\roaming\25assist\settings.dat.old" (
	echo Deleting older settings backup file... Working...
	del /Q settings.dat.old
) else (
	echo Proceeding....
)
cd %APPDATA%\25Assist
if exist "C:\users\%username%\appdata\roaming\25assist\settings.dat" (
	echo Settings file found! Working...
	ren settings.dat settings.dat.old
) else (
	echo Settings file NOT found!
	pause
	exit /B
)
cd %APPDATA%\25Assist
if exist "C:\users\%username%\appdata\roaming\25assist\settings.dat" (
	echo Deleting settings file... backup Saved. Working...
	del /Q settings.dat
) else (
	echo Proceeding....
)
powershell -Command "(Get-Content settings.dat.old) | ForEach-Object { $_ -replace 'Sourceforge', 'AAO25.com' } | Set-Content settings.dat"
echo ALL DONE!!!!
echo Exiting in 10 seconds...
ping -4 -n 12 127.0.0.1>nul
exit