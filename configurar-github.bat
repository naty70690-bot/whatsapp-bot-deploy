@echo off
REM WhatsApp Bot - Configuração Rápida do GitHub
echo.
echo ===============================================
echo   ⚡ CONFIGURAÇÃO RÁPIDA - GitHub
echo ===============================================
echo.
echo Digite seu username do GitHub e eu configuro tudo!
echo.

set /p GITHUB_USER="Seu username do GitHub: "

if "%GITHUB_USER%"=="" (
    echo ❌ Username obrigatório!
    pause
    exit /b 1
)

echo.
echo ✅ Configurando para: %GITHUB_USER%
echo.

REM Configurar remote
"C:\Program Files\Git\bin\git.exe" remote set-url origin https://github.com/%GITHUB_USER%/whatsapp-bot-deploy.git

echo ✅ Remote configurado!
echo.

REM Testar conexão
echo 🔍 Testando conexão...
"C:\Program Files\Git\bin\git.exe" ls-remote origin >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Repositório não encontrado!
    echo.
    echo 📋 CRIE O REPOSITÓRIO:
    echo https://github.com/new
    echo Nome: whatsapp-bot-deploy
    echo Público: SIM
    echo.
    pause
    exit /b 1
)

echo ✅ Repositório OK!
echo.
echo 🎯 PRÓXIMO: Execute 'deploy-automatico.bat'
echo.

pause