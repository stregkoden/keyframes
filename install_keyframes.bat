@ECHO OFF

SET projectname=keyframes

ECHO.&&ECHO.
ECHO                     github.com/samisalreadytaken/%projectname%
ECHO.&&ECHO.

REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam">NUL 2>NUL
IF ERRORLEVEL 1 GOTO NOREG

FOR /F "tokens=2* skip=2" %%a IN ('REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam" /v "SteamPath"') DO SET csgo=%%b
SET "csgo=%csgo%/steamapps/common/counter-strike global offensive/"
IF NOT EXIST "%csgo%/csgo/" GOTO NODIR

ECHO Found game directory:
ECHO %csgo%
ECHO.
IF EXIST "%csgo%/csgo/scripts/vscripts/keyframes.nut" ( ECHO Updating files... ) ELSE ( ECHO Installing... )
ECHO.

CD /d %csgo%
ECHO ===============================================================================
curl -L -o samisalreadytaken.bat.tar.gz https://codeload.github.com/samisalreadytaken/%projectname%/tar.gz/master

:DOWNLOADING
TASKLIST /fi "IMAGENAME eq curl.exe" >NUL
IF ERRORLEVEL 1 TIMEOUT /t 1 & GOTO DOWNLOADING

tar -xzf samisalreadytaken.bat.tar.gz --strip=1 %projectname%-master/csgo && DEL samisalreadytaken.bat.tar.gz
ECHO ===============================================================================
ECHO.
ECHO Success!
ECHO.
ECHO Press any key to exit...
PAUSE >nul
GOTO:EOF

:NODIR
ECHO.
ECHO ERROR: Could not find game directory at:
ECHO        %csgo%
ECHO.
ECHO Press any key to exit...
PAUSE >nul
GOTO:EOF

:NOREG
ECHO.
ECHO ERROR: Could not find Steam installation!
ECHO.
ECHO Press any key to exit...
PAUSE >nul
GOTO:EOF