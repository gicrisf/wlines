@echo off
REM Start wlines daemon with custom configuration
REM This script reads configuration from daemon-config.txt

cd /d "%~dp0"
setlocal EnableDelayedExpansion

REM Check if daemon is already running
tasklist /fi "imagename eq wlines-daemon.exe" /fo csv /nh | findstr /i "wlines-daemon.exe" >NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo wlines daemon is already running
    exit /b 0
)

REM Check if daemon executable exists
if not exist "wlines-daemon.exe" (
    echo Error: wlines-daemon.exe not found in current directory
    echo Current directory: %CD%
    pause
    exit /b 1
)

REM Read configuration file and build command line
set "DAEMON_ARGS="
if exist "daemon-config.txt" (
    echo Loading configuration from daemon-config.txt...
    for /f "tokens=* delims=" %%a in ('type daemon-config.txt ^| findstr /v "^#" ^| findstr /v "^$"') do (
        set "DAEMON_ARGS=!DAEMON_ARGS! %%a"
    )
) else (
    echo No configuration file found, using defaults
)

REM Start the daemon with configuration
echo Starting wlines daemon with configuration: !DAEMON_ARGS!
start "" wlines-daemon.exe !DAEMON_ARGS!

echo wlines daemon started
exit /b 0
