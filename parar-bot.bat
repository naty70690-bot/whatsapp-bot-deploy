@echo off
REM WhatsApp Bot - Stop Script
echo.
echo ===============================================
echo   WhatsApp Bot - Parar Servidores
echo ===============================================
echo.
echo Parando processos...
echo.

REM Kill node processes
taskkill /IM node.exe /F >nul 2>&1

REM Kill any remaining processes on ports
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :5000') do taskkill /PID %%a /F >nul 2>&1

echo.
echo ===============================================
echo              SERVIDORES PARADOS!
echo ===============================================
echo.
echo ✅ Todos os processos foram encerrados
echo.
pause