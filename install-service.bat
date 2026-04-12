@echo off
REM WhatsApp Bot Service Installer
REM This script installs the WhatsApp bot as a Windows service

echo WhatsApp Bot Service Installer
echo ================================

REM Check if NSSM is available (Non-Sucking Service Manager)
where nssm >nul 2>nul
if %errorlevel% neq 0 (
    echo NSSM not found. Downloading NSSM...
    powershell -Command "& {Invoke-WebRequest -Uri 'https://nssm.cc/release/nssm-2.24.zip' -OutFile 'nssm.zip'}"
    powershell -Command "& {Expand-Archive -Path 'nssm.zip' -DestinationPath 'nssm' -Force}"
    set "NSSM_PATH=%~dp0nssm\nssm-2.24\win64\nssm.exe"
) else (
    set "NSSM_PATH=nssm"
)

REM Get the current directory
set "SERVICE_DIR=%~dp0"
set "SERVICE_NAME=WhatsAppBot"

echo Installing WhatsApp Bot service...
echo Service Directory: %SERVICE_DIR%
echo Service Name: %SERVICE_NAME%

REM Stop service if it exists
"%NSSM_PATH%" stop "%SERVICE_NAME%" >nul 2>nul
"%NSSM_PATH%" remove "%SERVICE_NAME%" confirm >nul 2>nul

REM Install the service
"%NSSM_PATH%" install "%SERVICE_NAME%" "node" "%SERVICE_DIR%backend\server.js"
"%NSSM_PATH%" set "%SERVICE_NAME%" AppDirectory "%SERVICE_DIR%backend"
"%NSSM_PATH%" set "%SERVICE_NAME%" Description "WhatsApp Automated Responses Bot"
"%NSSM_PATH%" set "%SERVICE_NAME%" Start SERVICE_AUTO_START
"%NSSM_PATH%" set "%SERVICE_NAME%" AppRestartDelay 5000

REM Set environment variables
"%NSSM_PATH%" set "%SERVICE_NAME%" AppEnvironmentExtra NODE_ENV=production

echo Service installed successfully!
echo.
echo To start the service: nssm start WhatsAppBot
echo To stop the service: nssm stop WhatsAppBot
echo To view logs: nssm edit WhatsAppBot (then check I/O tab)
echo.
echo The bot will now run in the background and start automatically with Windows.
echo You can access the web interface at http://localhost:3000
echo.
pause