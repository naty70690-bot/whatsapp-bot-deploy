@echo off
REM WhatsApp Bot Connectivity Test
echo ===============================================
echo   WhatsApp Bot - Teste de Conectividade
echo ===============================================
echo.

echo Verificando servidores locais...
echo.

REM Test backend
curl -s http://localhost:5000/api/status >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Backend: http://localhost:5000 (OK)
) else (
    echo ❌ Backend: http://localhost:5000 (FALHA)
)

REM Test frontend
curl -s http://localhost:3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Frontend: http://localhost:3000 (OK)
) else (
    echo ❌ Frontend: http://localhost:3000 (FALHA)
)

echo.
echo ===============================================
echo   Acesso Remoto (outros dispositivos)
echo ===============================================
echo.

REM Get IP
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /C:"IPv4"') do (
    set IP=%%a
    goto :found
)
:found
set IP=%IP:~1%

echo 🌐 IP da sua máquina: %IP%
echo.
echo 📱 Acesse via telefone/tablet:
echo    Frontend: http://%IP%:3000
echo    Backend:  http://%IP%:5000/api/status
echo.
echo ⚠️  IMPORTANTE:
echo - Mesmo WiFi para PC e dispositivo móvel
echo - Se não funcionar, desative firewall temporariamente
echo - Ou execute como administrador: quick-start.bat
echo.
echo ===============================================
pause