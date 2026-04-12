@echo off
REM WhatsApp Bot - Push Seguro para GitHub
echo.
echo ===============================================
echo   🔒 PUSH SEGURO PARA GITHUB
echo ===============================================
echo.
echo Este script garante que estamos no diretório correto
echo e executa todos os comandos necessários.
echo.

REM Garantir que estamos no diretório correto
cd /d "C:\Users\cauaaa\Documents\whatsapp-bot"
if %errorlevel% neq 0 (
    echo ❌ ERRO: Não conseguiu acessar o diretório do projeto
    echo Verifique se o caminho está correto
    pause
    exit /b 1
)

echo ✅ Diretório correto: %CD%
echo.

REM Verificar se é um repositório git
"C:\Program Files\Git\bin\git.exe" status >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERRO: Este não é um repositório Git
    echo Execute primeiro: git init
    pause
    exit /b 1
)

echo ✅ Repositório Git encontrado
echo.

REM Verificar remote
"C:\Program Files\Git\bin\git.exe" remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERRO: Remote 'origin' não configurado
    echo Configure com: git remote add origin https://github.com/SEU_USERNAME/whatsapp-bot-deploy.git
    pause
    exit /b 1
)

echo ✅ Remote configurado
echo.

REM Commitar mudanças pendentes
"C:\Program Files\Git\bin\git.exe" status --porcelain | findstr . >nul
if %errorlevel% equ 0 (
    echo 📝 Tem mudanças pendentes, commitando...
    "C:\Program Files\Git\bin\git.exe" add .
    "C:\Program Files\Git\bin\git.exe" commit -m "Auto commit - %date% %time%"
    echo ✅ Mudanças commitadas
) else (
    echo ✅ Nenhum arquivo pendente
)

echo.
echo 🚀 Fazendo push para GitHub...
echo.

REM Tentar push
"C:\Program Files\Git\bin\git.exe" push -u origin master

if %errorlevel% equ 0 (
    echo.
    echo ===============================================
    echo   🎉 PUSH CONCLUÍDO COM SUCESSO!
    echo ===============================================
    echo.
    echo ✅ Código enviado para GitHub
    echo.
    echo 📋 PRÓXIMOS PASSOS:
    echo.
    echo 1. 🌐 Acesse: https://railway.app
    echo 2. 🔗 Conecte sua conta GitHub
    echo 3. 📦 Selecione: whatsapp-bot-deploy
    echo 4. 🚀 Clique: "Deploy"
    echo.
    echo ⏱️  AGUARDE 5-10 minutos
    echo.
    echo 🎊 SEU BOT ESTARÁ ONLINE!
    echo.
) else (
    echo.
    echo ❌ ERRO NO PUSH!
    echo.
    echo 🔧 POSSÍVEIS CAUSAS:
    echo.
    echo 1. 📝 Remote não configurado corretamente
    echo    Solução: git remote set-url origin https://github.com/SEU_USERNAME/whatsapp-bot-deploy.git
    echo.
    echo 2. 🔐 Autenticação necessária
    echo    Solução: Faça login no GitHub no navegador
    echo.
    echo 3. 📁 Repositório não existe
    echo    Solução: Crie o repositório no GitHub primeiro
    echo.
    echo 💡 COMANDO MANUAL:
    echo cd "C:\Users\cauaaa\Documents\whatsapp-bot"
    echo git push -u origin master
    echo.
)

pause