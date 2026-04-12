@echo off
REM WhatsApp Bot - Usar LocalTunnel (Sem Instalação)
echo.
echo ===============================================
echo   🚀 WhatsApp Bot + LocalTunnel
echo ===============================================
echo.
echo Expondo seu bot sem instalar nada!
echo.

REM Verificar se node/npm está instalado
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js não encontrado!
    echo 📥 Baixe em: https://nodejs.org
    pause
    exit /b 1
)

echo ✅ Node.js encontrado!
echo.

REM Iniciar backend
echo Iniciando backend...
start "WhatsApp Bot Backend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\backend && node server.js"

timeout /t 3 /nobreak >nul

REM Iniciar frontend
echo Iniciando frontend...
start "WhatsApp Bot Frontend" cmd /k "cd /d C:\Users\cauaaa\Documents\whatsapp-bot\frontend && npm start"

timeout /t 8 /nobreak >nul

echo.
echo ===============================================
echo   🌐 EXPONDO SERVIDORES...
echo ===============================================
echo.

REM Expor frontend com localtunnel
echo Expondo frontend (porta 3000)...
echo 📱 Abra outro terminal e rode:
echo npx localtunnel --port 3000
echo.
echo 🔗 URL aparecerá tipo: https://xxxxx.loca.lt
echo.

REM Para backend seria necessário outro terminal
echo 📡 Para expor o backend também:
echo npx localtunnel --port 5000
echo.

echo ===============================================
echo   ✅ PRONTO PARA USO!
echo ===============================================
echo.
echo 📋 INSTRUÇÕES:
echo 1. Abra um novo terminal (PowerShell)
echo 2. Rode: npx localtunnel --port 3000
echo 3. Copie a URL que aparecer
echo 4. Compartilhe com seus clientes
echo.
echo ⚠️  LIMITAÇÕES:
echo - URLs mudam frequentemente
echo - Pode ser lento na primeira vez
echo - Não use para produção
echo.
echo 💡 PARA PRODUÇÃO REAL:
echo - Use Railway: preparar-deploy.bat
echo - URLs permanentes e rápidas
echo.
pause