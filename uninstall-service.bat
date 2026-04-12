@echo off
REM WhatsApp Bot Service Uninstaller

echo WhatsApp Bot Service Uninstaller
echo ================================

set "SERVICE_NAME=WhatsAppBot"

echo Stopping and removing WhatsApp Bot service...

REM Check if NSSM is available
where nssm >nul 2>nul
if %errorlevel% neq 0 (
    if exist "%~dp0nssm\nssm-2.24\win64\nssm.exe" (
        set "NSSM_PATH=%~dp0nssm\nssm-2.24\win64\nssm.exe"
    ) else (
        echo NSSM not found. Please run install-service.bat first.
        pause
        exit /b 1
    )
) else (
    set "NSSM_PATH=nssm"
)

REM Stop and remove service
"%NSSM_PATH%" stop "%SERVICE_NAME%" >nul 2>nul
"%NSSM_PATH%" remove "%SERVICE_NAME%" confirm >nul 2>nul

echo Service removed successfully!
echo.
pause