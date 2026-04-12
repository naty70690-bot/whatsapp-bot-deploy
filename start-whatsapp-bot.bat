@echo off
set "NODE_PATH=C:\Program Files\nodejs"
set "PATH=%NODE_PATH%;%PATH%"
cd /d "%~dp0backend"
start "WhatsApp Bot Backend" cmd /k "npm start"
cd /d "%~dp0frontend"
start "WhatsApp Bot Frontend" cmd /k "npm start"
timeout /t 2 /nobreak >nul
start "" "http://localhost:3000"
echo.
echo WhatsApp Bot iniciado. Aguarde os servidores carregarem.
pause
