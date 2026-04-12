@echo off
echo ========================================
echo    WhatsApp Bot - Deploy Script
echo ========================================
echo.

cd /d "%~dp0backend"

echo [1/4] Installing dependencies (including Telegram support)...
call npm install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo [2/4] Building executable...
call npm run build
if %errorlevel% neq 0 (
    echo ERROR: Failed to build executable
    pause
    exit /b 1
)

echo.
echo [3/4] Creating distribution folder...
if not exist "..\dist" mkdir "..\dist"
if not exist "..\dist\frontend" mkdir "..\dist\frontend"

echo.
echo [4/4] Copying frontend files...
xcopy "..\frontend\build\*" "..\dist\frontend\" /E /I /H /Y 2>nul
if %errorlevel% neq 0 (
    echo WARNING: Frontend build not found. Run 'npm run build' in frontend folder first.
)

echo.
echo ========================================
echo    DEPLOY COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo Files created in: %~dp0dist\
echo.
echo To run the bot:
echo 1. Go to dist folder
echo 2. Double-click: whatsapp-bot-backend-win.exe
echo 3. Open browser: http://localhost:3000
echo.
echo The executable includes everything needed!
echo.
pause