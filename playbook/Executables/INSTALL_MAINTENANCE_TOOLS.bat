@echo off
setlocal EnableExtensions

set "TOOLROOT=%ProgramFiles%\JarvisOS Tools"
set "STARTMENU=%ProgramData%\Microsoft\Windows\Start Menu\Programs\JarvisOS Tools"
set "PUBLICDESKTOP=%PUBLIC%\Desktop"
set "ATLAS_MODULES=%windir%\AtlasModules"
set "ATLAS_DESKTOP=%windir%\AtlasDesktop"

if not exist "%TOOLROOT%" mkdir "%TOOLROOT%"
if not exist "%STARTMENU%" mkdir "%STARTMENU%"

set "DO_PRIVACY="
set "DO_APPFETCH="
set "DO_ATLAS="

if "%~1"=="" (
    set "DO_PRIVACY=1"
    set "DO_APPFETCH=1"
    set "DO_ATLAS=1"
)

:parse
if "%~1"=="" goto run
if /i "%~1"=="/privacy" set "DO_PRIVACY=1"
if /i "%~1"=="/appfetch" set "DO_APPFETCH=1"
if /i "%~1"=="/atlas" set "DO_ATLAS=1"
shift
goto parse

:run
if defined DO_PRIVACY if exist "%~dp0privacy+_settings.exe" (
    copy /y "%~dp0privacy+_settings.exe" "%TOOLROOT%\privacy+_settings.exe" >nul
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws=New-Object -ComObject WScript.Shell; $s=$ws.CreateShortcut('%STARTMENU%\Privacy+ Settings.lnk'); $s.TargetPath='%TOOLROOT%\privacy+_settings.exe'; $s.WorkingDirectory='%TOOLROOT%'; $s.Save()"
)

if defined DO_APPFETCH if exist "%~dp0appfetch.exe" (
    copy /y "%~dp0appfetch.exe" "%TOOLROOT%\appfetch.exe" >nul
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws=New-Object -ComObject WScript.Shell; $s=$ws.CreateShortcut('%STARTMENU%\App Fetch.lnk'); $s.TargetPath='%TOOLROOT%\appfetch.exe'; $s.WorkingDirectory='%TOOLROOT%'; $s.Save()"
)

if defined DO_ATLAS if exist "%~dp0AtlasModules" (
    if exist "%ATLAS_MODULES%" rmdir /s /q "%ATLAS_MODULES%"
    xcopy "%~dp0AtlasModules" "%ATLAS_MODULES%\" /E /I /H /Y >nul
)

if defined DO_ATLAS if exist "%~dp0AtlasDesktop" (
    if exist "%ATLAS_DESKTOP%" rmdir /s /q "%ATLAS_DESKTOP%"
    xcopy "%~dp0AtlasDesktop" "%ATLAS_DESKTOP%\" /E /I /H /Y >nul
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws=New-Object -ComObject WScript.Shell; $s=$ws.CreateShortcut('%PUBLICDESKTOP%\AtlasDesktop.lnk'); $s.TargetPath='%ATLAS_DESKTOP%'; $s.IconLocation='%ATLAS_MODULES%\Other\atlas-folder.ico,0'; $s.Save(); $m=$ws.CreateShortcut('%STARTMENU%\AtlasDesktop.lnk'); $m.TargetPath='%ATLAS_DESKTOP%'; $m.IconLocation='%ATLAS_MODULES%\Other\atlas-folder.ico,0'; $m.Save()"
)

exit /b 0
