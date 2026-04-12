@echo off
REM WhatsApp Bot - Push para GitHub
echo.
echo ===============================================
echo   📤 Fazendo Push para GitHub
echo ===============================================
echo.
echo Certifique-se de ter criado o repositório no GitHub!
echo.

REM Verificar se tem mudanças para commitar
cd /d C:\Users\cauaaa\Documents\whatsapp-bot
"C:\Program Files\Git\bin\git.exe" status --porcelain >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Erro ao verificar status do Git
    pause
    exit /b 1
)

"C:\Program Files\Git\bin\git.exe" status --porcelain | findstr . >nul
if %errorlevel% equ 0 (
    echo 📝 Tem arquivos modificados, fazendo commit...
    "C:\Program Files\Git\bin\git.exe" add .
    "C:\Program Files\Git\bin\git.exe" commit -m "Deploy ready - %date% %time%"
)

echo 🚀 Fazendo push para GitHub...
"C:\Program Files\Git\bin\git.exe" push -u origin master

if %errorlevel% equ 0 (
    echo.
    echo ===============================================
    echo   ✅ PUSH CONCLUÍDO!
    echo ===============================================
    echo.
    echo 🌐 Seu código está no GitHub!
    echo.
    echo 📋 PRÓXIMO PASSO:
    echo 1. Vá para: https://railway.app
    echo 2. Conecte sua conta GitHub
    echo 3. Selecione o repositório: whatsapp-bot-deploy
    echo 4. Clique em "Deploy"
    echo.
    echo 🎉 Seu bot estará online em minutos!
    echo.
) else (
    echo.
    echo ❌ ERRO no push!
    echo.
    echo 🔧 POSSÍVEIS SOLUÇÕES:
    echo 1. Verifique se criou o repositório no GitHub
    echo 2. Confirme o nome do repositório
    echo 3. Use suas credenciais corretas
    echo.
    echo 💡 COMANDO MANUAL:
    echo git push -u origin master
    echo.
)

pause