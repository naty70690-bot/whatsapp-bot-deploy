@echo off
REM WhatsApp Bot - Usar Ngrok para Exposição Pública
echo.
echo ===============================================
echo   🚀 WhatsApp Bot + Ngrok
echo ===============================================
echo.
echo Este script vai expor seu bot local publicamente
echo.

REM Verificar se ngrok está instalado
ngrok --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ngrok não encontrado!
    echo.
    echo 📥 BAIXE O NGROK:
    echo 1. Acesse: https://ngrok.com/download
    echo 2. Baixe a versão para Windows
    echo 3. Extraia ngrok.exe para uma pasta no PATH
    echo 4. Rode: ngrok config add-authtoken SEU_TOKEN
    echo.
    echo 🔑 Pegue seu token em: https://dashboard.ngrok.com/get-started/your-authtoken
    echo.
    pause
    exit /b 1
)

echo ✅ Ngrok encontrado!
echo.

REM Iniciar backend
echo Iniciando backend...
start "WhatsApp Bot Backend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\backend && node server.js"

timeout /t 3 /nobreak >nul

REM Iniciar frontend
echo Iniciando frontend...
start "WhatsApp Bot Frontend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\frontend && npm start"

timeout /t 5 /nobreak >nul

echo.
echo ===============================================
echo   🌐 EXPONDO SERVIDORES...
echo ===============================================
echo.

REM Expor backend
echo Expondo backend (porta 5000)...
start "Ngrok Backend" cmd /k "ngrok http 5000"

timeout /t 2 /nobreak >nul

REM Expor frontend
echo Expondo frontend (porta 3000)...
start "Ngrok Frontend" cmd /k "ngrok http 3000"

echo.
echo ===============================================
echo   ✅ SERVIDORES EXPOSTOS!
echo ===============================================
echo.
echo 📱 AGUARDE alguns segundos e acesse:
echo.
echo 🌐 https://dashboard.ngrok.com/status
echo.
echo 📋 Para ver as URLs públicas
echo.
echo ⚠️  IMPORTANTE:
echo - Mantenha este terminal aberto
echo - URLs mudam a cada execução
echo - Use apenas para testes/demos
echo - Para produção: use Railway/Render
echo.
echo 💡 DICAS:
echo - Compartilhe a URL do frontend com clientes
echo - O backend fica acessível via API
echo - Funciona em qualquer dispositivo
echo.
pause