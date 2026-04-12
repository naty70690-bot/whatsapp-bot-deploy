# WhatsApp & Telegram Bot - Deploy

## 🚀 Como Fazer Deploy

### Opção 1: Script Automático (Recomendado)

1. **Clique duplo** no arquivo `deploy.bat`
2. **Aguarde** o processo terminar
3. **Pronto!** Arquivos estarão na pasta `dist/`

### Opção 2: Manual

```bash
# Backend
cd backend
npm install
npm run build

# Frontend (opcional - para produção)
cd ../frontend
npm install
npm run build
```

## 📁 Arquivos Gerados

Após o deploy, você terá:

```
dist/
├── whatsapp-bot-backend-win.exe  # Executável principal
├── frontend/                     # Interface web (se construída)
└── whatsapp_bot.db              # Banco de dados
```

## ▶️ Como Usar

1. **Vá para a pasta `dist/`**
2. **Clique duplo** em `whatsapp-bot-backend-win.exe`
3. **Abra o navegador**: `http://localhost:3000`
4. **Configure** suas respostas automáticas
5. **Adicione bots do Telegram** na aba "Telegram Bots"

## ⚙️ Funcionalidades do Deploy

- ✅ **WhatsApp + Telegram** - Suporte completo para ambas plataformas
- ✅ **Executável standalone** - não precisa instalar Node.js
- ✅ **Banco de dados incluído** - SQLite embutido
- ✅ **Interface web** - painel de controle completo com 4 abas
- ✅ **QR Code** - autenticação WhatsApp
- ✅ **Bots do Telegram** - Configure múltiplos bots via @BotFather
- ✅ **Respostas automáticas** - com timer de 3 horas para ambas plataformas
- ✅ **Histórico** - todas as conversas salvas separadamente

## 🔧 Requisitos para Deploy

- Windows 10/11
- Conexão com internet (para WhatsApp)
- Conta WhatsApp válida

## 📞 Suporte

Se tiver problemas:
1. Verifique se todas as dependências foram instaladas
2. Certifique-se de que não há antivírus bloqueando
3. Execute como administrador se necessário

---

**Criado com ❤️ - WhatsApp Bot Deploy**