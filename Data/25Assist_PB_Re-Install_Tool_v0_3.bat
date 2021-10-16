@echo OFF
::21/06/2018 21:00 GMT -3
title [25Assist] PUNKBUSTER RE-INSTALL TOOL v0.3 ::Possessed::
color 5E
call :RequestAdminElevation "%~dpfs0" %* || goto:eof
echo THIS TOOL IS SUPPOSED TO RUN AS ADMIN BY IT SELF!
echo Running PB Services Tool - UN-INSTALLING...
echo DO NOT CLICK IN ANYHTHING, THE PROCESS IS AUTOMATIC!
ping -4 -n 5 127.0.0.1>nul
if exist pbsvc.exe (
	pbsvc.exe --uninstall --i-accept-the-pb-eula --no-prompts
) else (
	echo PB Service Tool NOT found! Downloading...
	::wget -q http://www.evenbalance.com/downloads/pbsvc/pbsvc.exe
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.evenbalance.com/downloads/pbsvc/pbsvc.exe', 'pbsvc.25assist')"
	ren pbsvc.25assist pbsvc.exe
	echo Running PB Services Tool - UN-INSTALLING...
	pbsvc.exe --uninstall --i-accept-the-pb-eula --no-prompts
)
echo PB Services have been Un-Installed...
ping -4 -n 3 127.0.0.1>nul
echo Stopping PB Executables...
QPROCESS * | find /i "PnkBstrB.exe" >nul 2>&1 && (
    echo process PnkBstrB.exe  is running
    taskkill /F /IM PnkBstrB.exe

) || (
    echo process PnkBstrB.exe  is not running.
)
QPROCESS * | find /i "PnkBstrA.exe" >nul 2>&1 && (
    echo process PnkBstrA.exe  is running
    taskkill /F /IM PnkBstrA.exe

) || (
    echo process PnkBstrA.exe  is not running.
)
ping -4 -n 3 127.0.0.1>nul
echo Deleting AAO 2.5.0 PB Directories...
if exist C:\users\%username%\appdata\local\punkbuster\AAO (
	del /Q C:\users\%username%\appdata\local\punkbuster\AAO
	echo AA 2.5.0 PB AppData files deleted!
) else (
	echo AA 2.5.0 PB Files directory 1 NOT found, proceeding...
)
if exist C:\users\%username%\appdata\roaming\25assist\armyops\system\pb (
	del /Q C:\users\%username%\appdata\roaming\25assist\armyops\system\pb
	echo AA 2.5.0 PB 25Assist files deleted!
) else (
	echo AA 2.5.0 PB Files directory 2 NOT found, proceeding...
)
ping -4 -n 3 127.0.0.1>nul
if exist "C:\Windows\System32\PnkBstrA.exe" (
	del C:\Windows\System32\PnkBstrA.exe
	echo S32 PnkBstrA deleted...
) else (
	echo S32 PnkBstrA.exe NOT found...
)
if exist "C:\Windows\System32\PnkBstrB.exe" (
	del C:\Windows\System32\PnkBstrB.exe
	echo S32 PnkBstrB deleted...
) else (
	echo S32 PnkBstrB.exe NOT found...
)
if exist "C:\Windows\SysWOW64\PnkBstrB.exe" (
	del C:\Windows\SysWOW64\PnkBstrB.exe
	echo SWOW64 PnkBstrB.exe deleted...
) else (
	echo SWOW64 PnkBstrB.exe NOT found...
)
if exist "C:\Windows\SysWOW64\PnkBstrA.exe" (
	del C:\Windows\SysWOW64\PnkBstrA.exe
	echo SWOW64 PnkBstrA deleted...
) else (
	echo SWOW64 PnkBstrA NOT found...
)
echo Running PB Services Tool - RE/INSTALLING...
echo DO NOT CLICK IN ANYHTHING, THE PROCESS IS AUTOMATIC!
ping -4 -n 5 127.0.0.1>nul
if exist "pbsvc.exe" (
	pbsvc.exe --install --i-accept-the-pb-eula --no-prompts
) else (
	::wget -q http://www.evenbalance.com/downloads/pbsvc/pbsvc.exe
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.evenbalance.com/downloads/pbsvc/pbsvc.exe', 'pbsvc.25assist')"
	ren pbsvc.25assist pbsvc.exe
	pbsvc.exe --install --i-accept-the-pb-eula --no-prompts
)
ping -4 -n 3 127.0.0.1>nul
echo PB Services have been Installed.
echo Looking for PB files...
if exist "pb-win.7z" (
	echo PB files found! ready to extract...
) else (
	echo PB files NOT found! Downloading PB files...
	::wget -q http://aa25assist.sourceforge.io/Data/pb-win.7z
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://aao25.com/assistdl/Data/pb-win.7z', 'pb-win.25assist')"
	ren pb-win.25assist pb-win.7z
)
ping -4 -n 3 127.0.0.1>nul
echo Extracting PB Files...
if exist "7za.exe" (
	7za.exe x pb-win.7z -oC:\users\%username%\appdata\roaming\25assist\armyops\system -x!AntiPoke.u -r -y >nul
	7za.exe x pb-win.7z -oC:\Users\%username%\AppData\Local\PunkBuster\AAO -x!AntiPoke.u -r -y >nul
) else (
	echo 7-ZIP executable NOT found! Downloading 7-ZIP...
	::wget -q http://aa25assist.sourceforge.io/Data/7za-win
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://aao25.com/assistdl/Data/7za-win', '7za-win.25assist')"
	ren 7za-win.25assist 7za.exe
	echo Extracting PB Files...
	7za.exe x pb-win.7z -oC:\users\%username%\appdata\roaming\25assist\armyops\system -x!AntiPoke.u -r -y >nul
	7za.exe x pb-win.7z -oC:\Users\%username%\AppData\Local\PunkBuster\AAO -r -y >nul
)
ping -4 -n 3 127.0.0.1>nul
echo Allowing PunkBuster process on Windows Firewall...
ping -4 -n 3 127.0.0.1>nul
netsh advfirewall firewall show rule name="AppData PnkBstrB.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule AppData PnkBstrB.exe not exist. Creating...
netsh advfirewall firewall add rule name="AppData PnkBstrB.exe" dir=in action=allow program="C:\Users\%username%\AppData\Local\PunkBuster\AAO\PnkBstrB.exe" enable=yes
)

netsh advfirewall firewall show rule name="AppData PnkBstrA.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule AppData PnkBstrA.exe not exist. Creating...
netsh advfirewall firewall add rule name="AppData PnkBstrA.exe" dir=in action=allow program="C:\Users\%username%\AppData\Local\PunkBuster\AAO\PnkBstrA.exe" enable=yes
)

netsh advfirewall firewall show rule name="25Assist PnkBstrB.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule 25Assist PnkBstrB.exe not exist. Creating...
netsh advfirewall firewall add rule name="25Assist PnkBstrB.exe" dir=in action=allow program="C:\users\%username%\appdata\roaming\25assist\armyops\system\pb\PnkBstrB.exe" enable=yes
)

netsh advfirewall firewall show rule name="25Assist PnkBstrA.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule 25Assist PnkBstrA.exe not exist. Creating...
netsh advfirewall firewall add rule name="25Assist PnkBstrA.exe" dir=in action=allow program="C:\users\%username%\appdata\roaming\25assist\armyops\system\pb\PnkBstrA.exe" enable=yes
)

netsh advfirewall firewall show rule name="System32 PnkBstrB.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule System32 PnkBstrB.exe not exist. Creating...
netsh advfirewall firewall add rule name="System32 PnkBstrB.exe" dir=in action=allow program="C:\Windows\System32\PnkBstrB.exe" enable=yes
)

netsh advfirewall firewall show rule name="System32 PnkBstrA.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule System32 PnkBstrA.exe not exist. Creating...
netsh advfirewall firewall add rule name="System32 PnkBstrA.exe" dir=in action=allow program="C:\Windows\System32\PnkBstrA.exe" enable=yes
)

netsh advfirewall firewall show rule name="SysWOW64 PnkBstrB.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule SysWOW64 PnkBstrB.exe not exist. Creating...
netsh advfirewall firewall add rule name="SysWOW64 PnkBstrB.exe" dir=in action=allow program="C:\Windows\SysWOW64\PnkBstrB.exe" enable=yes
)

netsh advfirewall firewall show rule name="SysWOW64 PnkBstrA.exe" >nul
if not ERRORLEVEL 1 (
echo Rule already set, Skipping...

) else (
echo Rule SysWOW64 PnkBstrA.exe not exist. Creating...
netsh advfirewall firewall add rule name="SysWOW64 PnkBstrA.exe" dir=in action=allow program="C:\Windows\SysWOW64\PnkBstrA.exe" enable=yes
)
ping -4 -n 3 127.0.0.1>nul
if exist "C:\Windows\SysWOW64\PnkBstrB.exe" (
	copy /Y "C:\Windows\SysWOW64\PnkBstrB.exe" "C:\Windows\System32\PnkBstrB.exe"
	echo SWOW64 PnkBstrB.exe copied.
) else (
	echo SWOW64 PnkBstrB.exe NOT found...
)
if exist "C:\Windows\SysWOW64\PnkBstrA.exe" (
	copy /Y "C:\Windows\SysWOW64\PnkBstrA.exe" "C:\Windows\System32\PnkBstrA.exe"
	echo SWOW64 PnkBstrA copied.
) else (
	echo SWOW64 PnkBstrA NOT found...
)
ping -4 -n 3 127.0.0.1>nul
echo ALL DONE!
echo Not really needed, but... try Rebooting your PC as well...
echo Exiting in 12 seconds...
ping -4 -n 10 127.0.0.1>nul
exit
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:RequestAdminElevation FilePath %* || goto:eof
:: 
:: By:   Cyberponk,     v1.5 - 10/06/2016 - Changed the admin rights test method from cacls to fltmc
::          v1.4 - 17/05/2016 - Added instructions for arguments with ! char
::          v1.3 - 01/08/2015 - Fixed not returning to original folder after elevation successful
::          v1.2 - 30/07/2015 - Added error message when running from mapped drive
::          v1.1 - 01/06/2015
:: 
:: Func: opens an admin elevation prompt. If elevated, runs everything after the function call, with elevated rights.
:: Returns: -1 if elevation was requested
::           0 if elevation was successful
::           1 if an error occured
:: 
:: USAGE:
:: If function is copied to a batch file:
::     call :RequestAdminElevation "%~dpf0" %* || goto:eof
::
:: If called as an external library (from a separate batch file):
::     set "_DeleteOnExit=0" on Options
::     (call :RequestAdminElevation "%~dpf0" %* || goto:eof) && CD /D %CD%
::
:: If called from inside another CALL, you must set "_ThisFile=%~dpf0" at the beginning of the file
::     call :RequestAdminElevation "%_ThisFile%" %* || goto:eof
::
:: If you need to use the ! char in the arguments, the calling must be done like this, and afterwards you must use %args% to get the correct arguments:
::      set "args=%* "
::      call :RequestAdminElevation .....   use one of the above but replace the %* with %args:!={a)%
::      set "args=%args:{a)=!%" 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal ENABLEDELAYEDEXPANSION & set "_FilePath=%~1"
  if NOT EXIST "!_FilePath!" (echo/Read RequestAdminElevation usage information)
  :: UAC.ShellExecute only works with 8.3 filename, so use %~s1
  set "_FN=_%~ns1" & echo/%TEMP%| findstr /C:"(" >nul && (echo/ERROR: %%TEMP%% path can not contain parenthesis &pause &endlocal &fc;: 2>nul & goto:eof)
  :: Remove parenthesis from the temp filename
  set _FN=%_FN:(=%
  set _vbspath="%temp:~%\%_FN:)=%.vbs" & set "_batpath=%temp:~%\%_FN:)=%.bat"

  :: Test if we gave admin rights
  fltmc >nul 2>&1 || goto :_getElevation

  :: Elevation successful
  (if exist %_vbspath% ( del %_vbspath% )) & (if exist %_batpath% ( del %_batpath% )) 
  :: Set ERRORLEVEL 0, set original folder and exit
  endlocal & CD /D "%~dp1" & ver >nul & goto:eof

  :_getElevation
  echo/Requesting elevation...
  :: Try to create %_vbspath% file. If failed, exit with ERRORLEVEL 1
  echo/Set UAC = CreateObject^("Shell.Application"^) > %_vbspath% || (echo/&echo/Unable to create %_vbspath% & endlocal &md; 2>nul &goto:eof) 
  echo/UAC.ShellExecute "%_batpath%", "", "", "runas", 1 >> %_vbspath% & echo/wscript.Quit(1)>> %_vbspath%
  :: Try to create %_batpath% file. If failed, exit with ERRORLEVEL 1
  echo/@%* > "%_batpath%" || (echo/&echo/Unable to create %_batpath% & endlocal &md; 2>nul &goto:eof)
  echo/@if %%errorlevel%%==9009 (echo/^&echo/Admin user could not read the batch file. If running from a mapped drive or UNC path, check if Admin user can read it.)^&echo/^& @if %%errorlevel%% NEQ 0 pause >> "%_batpath%"

  :: Run %_vbspath%, that calls %_batpath%, that calls the original file
  %_vbspath% && (echo/&echo/Failed to run VBscript %_vbspath% &endlocal &md; 2>nul & goto:eof)

  :: Vbscript has been run, exit with ERRORLEVEL -1
  echo/&echo/Elevation was requested on a new CMD window &endlocal &fc;: 2>nul & goto:eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::