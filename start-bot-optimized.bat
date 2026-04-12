@echo off
REM WhatsApp Bot Optimized Startup Script
REM Supports both development and production modes

echo ========================================
echo    WhatsApp Bot - RM TECH
echo ========================================
echo.

REM Check if running as service
if "%1"=="service" goto service_mode

REM Development mode (default)
echo Starting in DEVELOPMENT mode...
echo Backend and Frontend will start in separate windows
echo Close the windows to stop the bot
echo.
echo Starting Backend Server...
start "WhatsApp Bot Backend" cmd /k "cd backend && npm start"

timeout /t 3 /nobreak >nul

echo Starting Frontend...
start "WhatsApp Bot Frontend" cmd /k "cd frontend && npm start"

timeout /t 2 /nobreak >nul

echo.
echo ========================================
echo Bot started successfully!
echo.
echo - Backend: http://localhost:5000
echo - Frontend: http://localhost:3000
echo.
echo To stop: Close the command windows
echo.
echo For production/service mode:
echo   run: start-bot.bat service
echo ========================================
goto end

:service_mode
echo Starting in PRODUCTION/SERVICE mode...
echo Bot will run in background
echo.

REM Check if NSSM is available for service installation
where nssm >nul 2>nul
if %errorlevel% neq 0 (
    echo NSSM not found. Installing as background process...
    echo Note: This window must stay open for the bot to run.
    echo.
    cd backend
    node server.js
    goto end
)

echo Installing WhatsApp Bot as Windows service...
set "SERVICE_NAME=WhatsAppBot"

REM Stop existing service if running
"%NSSM_PATH%" stop "%SERVICE_NAME%" >nul 2>nul

REM Install/update service
if exist "%~dp0backend\server.exe" (
    echo Using compiled executable...
    nssm install "%SERVICE_NAME%" "%~dp0backend\server.exe"
) else (
    echo Using Node.js script...
    nssm install "%SERVICE_NAME%" "node" "%~dp0backend\server.js"
    nssm set "%SERVICE_NAME%" AppDirectory "%~dp0backend"
)

nssm set "%SERVICE_NAME%" Description "WhatsApp Automated Responses Bot - RM TECH"
nssm set "%SERVICE_NAME%" Start SERVICE_AUTO_START
nssm set "%SERVICE_NAME%" AppRestartDelay 5000
nssm set "%SERVICE_NAME%" AppEnvironmentExtra NODE_ENV=production

echo Starting service...
nssm start "%SERVICE_NAME%"

echo.
echo ========================================
echo Service installed and started!
echo.
echo Service Name: %SERVICE_NAME%
echo Status: Running in background
echo.
echo Management commands:
echo   Stop:  nssm stop %SERVICE_NAME%
echo   Start: nssm start %SERVICE_NAME%
echo   Logs:  nssm edit %SERVICE_NAME% (I/O tab)
echo   Remove: nssm remove %SERVICE_NAME%
echo.
echo Web Interface: http://localhost:5000
echo ========================================

:end
pause