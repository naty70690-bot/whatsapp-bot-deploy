@echo off
REM WhatsApp Bot - Expor Localhost Publicamente (Temporário)
echo.
echo ===============================================
echo   🌐 Expor Localhost Publicamente
echo ===============================================
echo.
echo ⚠️  AVISO: Esta é uma solução TEMPORÁRIA
echo ⚠️  NÃO use para produção ou vendas reais
echo ⚠️  Pode ser instável e insegura
echo.
echo 📋 MÉTODOS DISPONÍVEIS:
echo.

REM Verificar se ngrok está instalado
ngrok --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ngrok não encontrado
    echo 📥 Baixe em: https://ngrok.com/download
    echo.
    goto :serveo
)

echo ✅ Ngrok encontrado!
echo.
echo 🔗 OPÇÃO 1: Ngrok (Recomendado)
echo Comandos:
echo   ngrok http 3000  (para frontend)
echo   ngrok http 5000  (para backend)
echo.
echo 📱 Seu bot ficará acessível em:
echo   https://xxxxx.ngrok.io
echo.
goto :serveo

:serveo
echo 🔗 OPÇÃO 2: Serveo (Gratuito, sem instalação)
echo Comandos:
echo   ssh -R 80:localhost:3000 serveo.net
echo.
echo 📱 Seu bot ficará acessível em:
echo   https://xxxxx.serveo.net
echo.

echo 🔗 OPÇÃO 3: LocalTunnel (Gratuito)
echo Comandos:
echo   npx localtunnel --port 3000
echo.
echo 📱 Seu bot ficará acessível em:
echo   https://xxxxx.loca.lt
echo.

echo.
echo ===============================================
echo   🚀 PARA PRODUÇÃO REAL:
echo ===============================================
echo.
echo Use Railway, Render ou Heroku:
echo - preparar-deploy.bat
echo - deploy-railway.bat
echo.
echo URLs permanentes e profissionais!
echo.
pause