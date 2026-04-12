@echo off
REM WhatsApp Bot - Testar Acesso Local
echo.
echo ===============================================
echo   🏠 Testar Acesso na Rede Local
echo ===============================================
echo.
echo Testando se outros dispositivos na mesma
echo rede WiFi podem acessar seu bot...
echo.

REM Pegar IP local
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /R /C:"IPv4 Address"') do (
    for /f "tokens=*" %%b in ("%%a") do set IP=%%b
)
set IP=%IP: =%

if "%IP%"=="" (
    echo ❌ Não foi possível detectar o IP local
    echo Verifique sua conexão de rede
    pause
    exit /b 1
)

echo ✅ Seu IP local: %IP%
echo.
echo 📱 URLs para testar:
echo.
echo 🌐 Frontend: http://%IP%:3000
echo 🔧 Backend:  http://%IP%:5000
echo.
echo 📋 COMO TESTAR:
echo.
echo 1. Mantenha este PC ligado
echo 2. No celular/tablet, conecte na mesma WiFi
echo 3. Abra o navegador e acesse as URLs acima
echo 4. Deve funcionar igual ao localhost
echo.
echo ⚠️  LIMITAÇÕES:
echo - Só funciona na mesma rede WiFi
echo - Não acessível de fora da sua casa
echo - Para internet: use ngrok ou Railway
echo.
echo 💡 PARA ACESSO PÚBLICO REAL:
echo usar-ngrok.bat
echo.
pause