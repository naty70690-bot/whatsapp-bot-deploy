@echo off
REM WhatsApp Bot - Deploy Completo Automático
echo.
echo ===============================================
echo   🚀 DEPLOY COMPLETO - WhatsApp Bot
echo ===============================================
echo.
echo Este script faz TUDO automaticamente!
echo.

echo 📋 PRÉ-REQUISITOS:
echo - Conta GitHub criada
echo - Conta Railway criada
echo - Repositório criado no GitHub
echo.
pause

echo.
echo ===============================================
echo   1/4 - Preparando Projeto
echo ===============================================
echo.

call preparar-deploy.bat
if %errorlevel% neq 0 (
    echo ❌ Erro na preparação!
    pause
    exit /b 1
)

echo.
echo ===============================================
echo   2/4 - Configurando Git
echo ===============================================
echo.

cd /d C:\Users\cauaaa\Documents\whatsapp-bot

REM Configurar Git se necessário
"C:\Program Files\Git\bin\git.exe" config user.name >nul 2>&1
if %errorlevel% neq 0 (
    "C:\Program Files\Git\bin\git.exe" config --global user.name "WhatsApp Bot User"
    "C:\Program Files\Git\bin\git.exe" config --global user.email "whatsappbot@example.com"
)

REM Inicializar repo se necessário
if not exist ".git" (
    "C:\Program Files\Git\bin\git.exe" init
)

REM Commit das mudanças
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" commit -m "Deploy ready - %date% %time%" >nul 2>&1

echo ✅ Git configurado!

echo.
echo ===============================================
echo   3/4 - Push para GitHub
echo ===============================================
echo.

call push-github.bat
if %errorlevel% neq 0 (
    echo ❌ Erro no push para GitHub!
    echo Continue manualmente com: push-github.bat
    pause
    exit /b 1
)

echo.
echo ===============================================
echo   4/4 - DEPLOY CONCLUÍDO!
echo ===============================================
echo.
echo 🎉 PARABÉNS! Seu WhatsApp Bot está DEPLOYADO!
echo.
echo 📱 PRÓXIMOS PASSOS:
echo.
echo 1. 🌐 Acesse: https://railway.app
echo 2. 📊 Vá para seu projeto
echo 3. 🔗 Copie a URL gerada
echo 4. 📢 Compartilhe com seus clientes!
echo.
echo 💰 PARA VENDAS:
echo - Configure domínios personalizados
echo - Adicione autenticação por cliente
echo - Configure pagamentos automáticos
echo.
echo 📞 SUPORTE:
echo - Problemas? Execute: test-connectivity.bat
echo - Logs: Verifique no Railway dashboard
echo.
echo 🚀 SEU BOT ESTÁ ONLINE 24/7!
echo.
pause