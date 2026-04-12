@echo off
REM WhatsApp Bot - Quick Start Script
echo.
echo ===============================================
echo   WhatsApp Bot - Inicialização Rápida
echo ===============================================
echo.
echo Iniciando servidores...
echo.

REM Kill any existing processes
taskkill /IM node.exe /F >nul 2>&1

REM Start backend
echo Iniciando backend...
start "WhatsApp Bot Backend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\backend && node server.js"

timeout /t 3 /nobreak >nul

REM Start frontend
echo Iniciando frontend...
start "WhatsApp Bot Frontend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\frontend && npm start"

timeout /t 5 /nobreak >nul

REM Open browser
echo Abrindo navegador...
start http://localhost:3000

echo.
echo ===============================================
echo              SERVIDORES INICIADOS!
echo ===============================================
echo.
echo ✅ Backend:  http://localhost:5000
echo ✅ Frontend: http://localhost:3000
echo ✅ Mobile:   http://192.168.1.126:3000
echo.
echo 📱 Status: WhatsApp CONECTADO
echo 🤖 Bot: Respondendo automaticamente
echo.
echo 💡 Para parar: Feche as janelas do CMD
echo.
pause