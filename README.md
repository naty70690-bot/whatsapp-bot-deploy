# 🤖 WhatsApp Bot Automático

Um bot inteligente para WhatsApp com interface web responsiva e respostas automáticas.

## 🚀 Funcionalidades

- ✅ **Autenticação QR Code** - Conexão segura via WhatsApp Web
- ✅ **Respostas Automáticas** - Configure mensagens personalizadas
- ✅ **Interface Web** - Gerencie tudo pelo navegador
- ✅ **Mobile Responsivo** - Acesse de qualquer dispositivo
- ✅ **Histórico de Conversas** - Acompanhe todas as mensagens
- ✅ **Serviço Windows** - Execute em segundo plano

## 📱 Como Usar

### Inicialização Rápida
1. Execute `iniciar-bot.bat`
2. Aguarde os servidores iniciarem
3. Abra http://localhost:3000 no navegador

### Acesso
- **Computador**: http://localhost:3000
- **Mobile**: http://192.168.1.126:3000 (mesma rede)

### Funcionalidades da Interface
1. **QR Code** - Conecte seu WhatsApp
2. **Mensagens** - Configure respostas automáticas
3. **Histórico** - Veja conversas passadas

## 🛠️ Scripts Disponíveis

- `iniciar-bot.bat` - Inicia todos os servidores
- `parar-bot.bat` - Para todos os processos
- `install-service.bat` - Instala como serviço Windows
- `uninstall-service.bat` - Remove o serviço Windows
- `test-connectivity.bat` - Testa conectividade

## 📋 Requisitos

- Node.js instalado
- WhatsApp Web no celular
- Porta 3000 e 5000 livres

## 🔧 Estrutura do Projeto

```
whatsapp-bot/
├── backend/          # Servidor Node.js
│   ├── server.js     # Servidor principal
│   ├── models/       # Modelos de dados
│   └── routes/       # APIs REST
├── frontend/         # Interface React
│   ├── src/          # Código fonte
│   └── public/       # Assets estáticos
└── scripts/          # Scripts de automação
```

## 📊 Status do Sistema

- ✅ Backend funcionando na porta 5000
- ✅ Frontend funcionando na porta 3000
- ✅ WhatsApp conectado e respondendo
- ✅ Banco de dados SQLite ativo
- ✅ API REST operacional

## 🐛 Problemas Comuns

### Não consegue acessar a interface?
1. Execute `iniciar-bot.bat`
2. Verifique se as portas 3000/5000 estão livres
3. Aguarde 10 segundos para inicialização

### WhatsApp não conecta?
1. Feche outros WhatsApp Web abertos
2. Escaneie o QR Code novamente
3. Aguarde a conexão estabelecer

### Mobile não acessa?
1. Verifique se está na mesma rede WiFi
2. Use o IP correto (192.168.1.126)
3. Desative firewall temporariamente

## 📞 Suporte

Para problemas, verifique:
1. Logs no terminal dos servidores
2. Execute `test-connectivity.bat`
3. Reinicie com `parar-bot.bat` e `iniciar-bot.bat`

## 🌐 **Deploy Público para Vendas**

Seu bot está pronto para ser vendido! Para torná-lo público:

### 🚀 **Opção 1: Railway (Recomendado)**
```bash
# 1. Preparar projeto
preparar-deploy.bat

# 2. Seguir guia de deploy
deploy-railway.bat

# 3. Acesse o DEPLOY-GUIDE.md para detalhes completos
```

### ⚡ **Opção 2: Exposição Temporária (Rápido)**
```bash
# Para testes/demos rápidas
usar-ngrok.bat        # Melhor opção (requer ngrok)
usar-localtunnel.bat  # Sem instalação
expor-localhost.bat   # Ver todas opções
```

### 📋 **O que você ganha:**
- ✅ **URL pública**: `https://seu-bot.railway.app`
- ✅ **Acesso de qualquer lugar**
- ✅ **Vendas ilimitadas**
- ✅ **Clientes acessam diretamente**

### 💰 **Planos:**
- **Free**: Até 512MB RAM (suficiente para testes)
- **Hobby**: $5/mês (recomendado para vendas)
- **Pro**: $10/mês (alta performance)

## 🚀 **Deploy Imediato**

Para fazer deploy AGORA mesmo:

```bash
# Deploy completo automático
deploy-completo.bat
```

Ou passo a passo:
```bash
# 1. Preparar
preparar-deploy.bat

# 2. Push para GitHub
push-github.bat

# 3. Deploy no Railway
# Acesse: https://railway.app
```

### 📋 **O que Acontece:**

1. ✅ **Projeto preparado** para produção
2. ✅ **Build do frontend** otimizado
3. ✅ **Código no GitHub** versionado
4. ✅ **Deploy no Railway** automático
5. ✅ **URL pública** gerada

### 💰 **Custos:**
- **Railway Free**: Até 512MB RAM
- **Railway Hobby**: $5/mês (recomendado)

---

**Desenvolvido com ❤️ para automação de WhatsApp**
