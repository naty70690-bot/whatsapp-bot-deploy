@echo off
REM WhatsApp Bot - Deploy Automático Completo
echo.
echo ===============================================
echo   🤖 DEPLOY AUTOMÁTICO - WhatsApp Bot
echo ===============================================
echo.
echo Vou fazer TODO o deploy para você!
echo Só preciso do seu username do GitHub.
echo.

set /p GITHUB_USER="Digite seu username do GitHub (ex: joaosilva): "

if "%GITHUB_USER%"=="" (
    echo ❌ Username não pode ser vazio!
    pause
    exit /b 1
)

echo.
echo ✅ Username: %GITHUB_USER%
echo.

REM Configurar remote correto
echo 🔧 Configurando remote...
"C:\Program Files\Git\bin\git.exe" remote set-url origin https://github.com/%GITHUB_USER%/whatsapp-bot-deploy.git

REM Verificar se o repositório existe (tentar fetch)
echo 🔍 Verificando repositório...
"C:\Program Files\Git\bin\git.exe" ls-remote --exit-code origin >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERRO: Repositório não encontrado!
    echo.
    echo 📋 CRIE O REPOSITÓRIO PRIMEIRO:
    echo.
    echo 1. Vá para: https://github.com
    echo 2. Clique: "New repository"
    echo 3. Nome: whatsapp-bot-deploy
    echo 4. Deixe PUBLIC
    echo 5. NÃO marque "Add README"
    echo 6. Clique: "Create repository"
    echo.
    echo 7. Execute este script novamente
    echo.
    pause
    exit /b 1
)

echo ✅ Repositório encontrado!
echo.

REM Commitar mudanças pendentes
echo 📝 Commitando mudanças...
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" commit -m "Deploy auto - %date% %time%" >nul 2>&1

REM Fazer push
echo 🚀 Fazendo push...
"C:\Program Files\Git\bin\git.exe" push -u origin master

if %errorlevel% equ 0 (
    echo.
    echo ===============================================
    echo   🎉 DEPLOY CONCLUÍDO - PARTE 1/2
    echo ===============================================
    echo.
    echo ✅ Código enviado para GitHub!
    echo.
    echo 📋 PRÓXIMA ETAPA - RAILWAY:
    echo.
    echo 1. 🌐 Abra: https://railway.app
    echo 2. 🔗 Login com GitHub
    echo 3. 📦 "Start a new project"
    echo 4. 🔍 "Deploy from GitHub repo"
    echo 5. 📁 Selecione: %GITHUB_USER%/whatsapp-bot-deploy
    echo 6. 🚀 Clique: "Deploy"
    echo.
    echo ⏱️  AGUARDE 5-10 minutos...
    echo.
    echo 🎊 SEU BOT ESTARÁ ONLINE!
    echo.
    echo 💡 URL será tipo: https://xxxxx.railway.app
    echo.
) else (
    echo.
    echo ❌ ERRO no push!
    echo.
    echo 🔧 POSSÍVEIS SOLUÇÕES:
    echo.
    echo 1. 📝 Verifique se criou o repositório correto
    echo 2. 🔐 Faça login no GitHub no navegador
    echo 3. 🌐 Verifique sua conexão com internet
    echo.
    echo 💡 TENTE NOVAMENTE em alguns minutos
    echo.
)

pause