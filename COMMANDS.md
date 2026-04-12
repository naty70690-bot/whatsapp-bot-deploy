# WhatsApp Bot - Scripts de Inicialização

## Para Windows PowerShell:

### Executar Backend
```powershell
cd $env:USERPROFILE\Documents\whatsapp-bot\backend
npm install
npm start
```

### Executar Frontend
```powershell
cd $env:USERPROFILE\Documents\whatsapp-bot\frontend
npm install
npm start
```

### Executar Ambos em uma Linha
```powershell
cd $env:USERPROFILE\Documents\whatsapp-bot ; Write-Host "Backend: cd backend && npm install && npm start" ; Write-Host "Frontend (new terminal): cd frontend && npm install && npm start"
```

---

## Para CMD (Prompt de Comando):

### Executar Backend
```cmd
cd %USERPROFILE%\Documents\whatsapp-bot\backend
npm install
npm start
```

### Executar Frontend
```cmd
cd %USERPROFILE%\Documents\whatsapp-bot\frontend
npm install
npm start
```

---

## Para Git Bash ou Mac/Linux:

### Executar Backend
```bash
cd ~/Documents/whatsapp-bot/backend
npm install
npm start
```

### Executar Frontend
```bash
cd ~/Documents/whatsapp-bot/frontend
npm install
npm start
```

---

## Modo Desenvolvimento (with hot-reload)

Backend com Nodemon (auto-restart):
```bash
cd backend
npm install
npm run dev
```

Frontend com React Scripts (hot-reload automático):
```bash
cd frontend
npm install
npm start
```

---

## Build para Produção

Frontend:
```bash
cd frontend
npm run build
```

---

## Reinstalar Dependências (em caso de erro)

Backend:
```bash
cd backend
rm -r node_modules package-lock.json  # On Mac/Linux
rmdir /s node_modules  # On Windows
npm cache clean --force
npm install
```

Frontend:
```bash
cd frontend
rm -r node_modules package-lock.json  # On Mac/Linux
rmdir /s node_modules  # On Windows
npm cache clean --force
npm install
```

---

## Verificar Portas Abertas

PowerShell:
```powershell
Get-NetTCPConnection -State Listen | Where-Object {$_.LocalPort -in 3000,5000}
```

CMD:
```cmd
netstat -ano | findstr :3000
netstat -ano | findstr :5000
```

---

## Matar Processo na Porta

PowerShell:
```powershell
Get-Process | Where-Object {$_.Name -eq "node"} | Stop-Process -Force
```

CMD:
```cmd
taskkill /IM node.exe /F
```

---

## Verificar Instalação Node.js

```bash
node --version
npm --version
```

---

**Salve este arquivo para referência rápida!**
