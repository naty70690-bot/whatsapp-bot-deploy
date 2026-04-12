@echo off
REM WhatsApp Bot Quick Start
REM Optimized for fast startup and mobile control

echo.
echo ===============================================
echo   WhatsApp Bot Otimizado - RM TECH
echo ===============================================
echo.
echo Este bot foi otimizado para:
echo ✅ Funcionar em segundo plano (PC pode ser desligado)
echo ✅ Interface mobile responsiva
echo ✅ QR Code ultra-rápido
echo ✅ Carregamento instantâneo quando conectado
echo ✅ Reconexão automática
echo.
echo ===============================================
echo.

REM Check if already running
tasklist /FI "IMAGENAME eq node.exe" /FI "WINDOWTITLE eq WhatsApp Bot*" 2>NUL | find /I /N "node.exe">NUL
if %ERRORLEVEL% EQU 0 (
    echo ⚠️  Bot já está executando!
    echo.
    echo Acesse: http://localhost:3000
    echo.
    goto management
)

REM Check if service is installed
sc query "WhatsAppBot" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo 🔄 Iniciando serviço WhatsApp Bot...
    net start "WhatsAppBot" >nul 2>&1
    timeout /t 3 /nobreak >nul
    goto check_service
)

REM Start in development mode
echo 🚀 Iniciando WhatsApp Bot...
echo.
echo Modo: DESENVOLVIMENTO
echo Backend: http://localhost:5000
echo Frontend: http://localhost:3000
echo.

start "WhatsApp Bot Backend" cmd /k "cd backend && npm start"
timeout /t 2 /nobreak >nul
start "WhatsApp Bot Frontend" cmd /k "cd frontend && npm start"
timeout /t 2 /nobreak >nul

echo ✅ Bot iniciado com sucesso!
echo.
echo 💡 Dicas:
echo - Feche as janelas para parar o bot
echo - Para produção, use: start-bot-optimized.bat service
echo - Acesse via mobile: http://[SEU_IP]:3000
echo.
goto end

:check_service
sc query "WhatsAppBot" | find "RUNNING" >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Serviço WhatsApp Bot está executando!
    echo.
    echo 🌐 Acesse: http://localhost:5000
    echo 📱 Mobile: http://[SEU_IP]:5000
) else (
    echo ❌ Serviço falhou ao iniciar
    echo Execute: start-bot-optimized.bat service
)
goto management

:management
echo.
echo ===============================================
echo              GERENCIAMENTO
echo ===============================================
echo.
echo Comandos úteis:
echo.
echo 📊 Status:     curl http://localhost:5000/api/status
echo 🔄 Reiniciar:  .\start-bot-optimized.bat
echo 🛑 Parar:      taskkill /IM node.exe /FI "WINDOWTITLE eq WhatsApp Bot*"
echo 🛠️  Serviço:    services.msc (procure "WhatsAppBot")
echo.
echo 📱 Acesse via navegador ou app mobile:
echo    http://localhost:3000
echo.

:end
echo ===============================================
pause