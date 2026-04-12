@echo off
REM WhatsApp Bot - Preparar para Deploy
echo.
echo ===============================================
echo   🚀 Preparando Projeto para Deploy
echo ===============================================
echo.

REM Criar .env se não existir
if not exist "backend\.env" (
    echo Criando arquivo .env...
    echo PORT=5000> backend\.env
    echo NODE_ENV=production>> backend\.env
    echo ADMIN_PASSWORD=admin123>> backend\.env
    echo DATABASE_URL=./whatsapp_bot.db>> backend\.env
)

REM Ajustar proxy do frontend
echo Ajustando proxy do frontend...
powershell -Command "(Get-Content frontend\package.json) -replace '\"proxy\": \"http://localhost:5000\"', '\"proxy\": \"https://SEU_BACKEND_URL\"' | Set-Content frontend\package.json"

REM Build do frontend
echo Fazendo build do frontend...
cd frontend
call npm run build
cd ..

REM Criar railway.json
echo Criando railway.json...
echo {> railway.json
echo   "build": {>> railway.json
echo     "builder": "NIXPACKS">> railway.json
echo   },>> railway.json
echo   "deploy": {>> railway.json
echo     "startCommand": "cd backend && npm start">> railway.json
echo   }>> railway.json
echo }>> railway.json

echo.
echo ===============================================
echo         ✅ PREPARAÇÃO CONCLUÍDA!
echo ===============================================
echo.
echo 📋 PRÓXIMOS PASSOS:
echo 1. Edite o .env com suas configurações
echo 2. Suba o projeto para GitHub
echo 3. Faça deploy no Railway/Render
echo 4. Configure o domínio personalizado
echo.
echo 📁 Arquivos criados/modificados:
echo - backend/.env
echo - frontend/package.json (proxy ajustado)
echo - frontend/build/ (build pronto)
echo - railway.json
echo.
pause