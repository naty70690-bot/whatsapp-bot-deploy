@echo off
REM WhatsApp Bot - Deploy para Railway
echo.
echo ===============================================
echo   🚂 Deploy para Railway
echo ===============================================
echo.
echo Este script vai te guiar pelo deploy...
echo.
echo 📋 PRÉ-REQUISITOS:
echo 1. Conta no GitHub
echo 2. Conta no Railway
echo 3. Projeto preparado (rode preparar-deploy.bat primeiro)
echo.
echo 📝 PASSOS PARA DEPLOY:
echo.
echo 1. 📤 SUBIR PARA GITHUB:
echo    git add .
echo    git commit -m "Ready for deploy"
echo    git push origin main
echo.
echo 2. 🌐 DEPLOY NO RAILWAY:
echo    - Acesse: https://railway.app
echo    - Clique: "Start a new project"
echo    - Escolha: "Deploy from GitHub repo"
echo    - Selecione: seu repositorio
echo    - Configure as variaveis de ambiente
echo.
echo 3. 🔧 VARIAVEIS DE AMBIENTE NO RAILWAY:
echo    NODE_ENV=production
echo    ADMIN_PASSWORD=sua_senha_segura
echo    DATABASE_URL=$${DATABASE_URL}
echo.
echo 4. 📊 ADICIONAR BANCO DE DADOS:
echo    - No Railway: Add -^> Database -^> PostgreSQL
echo    - Copie a DATABASE_URL para as variaveis
echo.
echo 5. 🌍 CONFIGURAR DOMINIO (OPCIONAL):
echo    - No Railway: Settings -^> Domains
echo    - Adicione seu dominio personalizado
echo.
echo ===============================================
echo   💡 DICAS IMPORTANTES:
echo ===============================================
echo.
echo 🔒 SEGURANÇA:
echo - Mude a ADMIN_PASSWORD para algo seguro
echo - Use HTTPS (Railway fornece automaticamente)
echo - Configure CORS corretamente
echo.
echo 💾 BANCO DE DADOS:
echo - Use PostgreSQL para producao
echo - SQLite funciona mas nao e recomendado
echo - Configure backups automaticos
echo.
echo 📱 WHATSAPP:
echo - Pode precisar reconectar apos deploy
echo - Teste a conexao QR Code
echo - Verifique se responde mensagens
echo.
echo ⚡ PERFORMANCE:
echo - Railway free: 512MB RAM
echo - Upgrade para Hobby se precisar mais
echo - Monitor usage no dashboard
echo.
pause