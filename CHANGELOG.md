# 📋 CHANGELOG - WhatsApp Bot

## [2.2.0] - 2026-04-11 - Remoção do Telegram (Contas Pessoais Não Suportadas)

### ❌ REMOVIDO
- **Telegram Integration** - Removido suporte ao Telegram devido a limitações técnicas
  - Removido `node-telegram-bot-api` dependency
  - Removido função `initTelegramBots()`
  - Removido rota `/api/telegram`
  - Removido componente `TelegramBots.js`
  - Removido aba "Telegram Bots" da interface

### 📜 MOTIVO DA REMOÇÃO
- **Políticas do Telegram** - Não permitem automação de contas pessoais
- **Limitações Técnicas** - Não existe API para QR code em contas pessoais
- **Conformidade** - Telegram só permite bots oficiais via @BotFather
- **Legal** - Automação de contas pessoais viola termos de serviço

### ✅ MELHORADO
- **Foco no WhatsApp** - Interface simplificada e otimizada
- **Performance** - Remoção de código desnecessário
- **Estabilidade** - Menos dependências e complexidade

### 📚 DOCUMENTAÇÃO
- **TELEGRAM_NAO_POSSIVEL.md** - Explicação detalhada sobre limitações do Telegram
- **README.md** - Atualizado para focar apenas no WhatsApp
- **package.json** - Descrição atualizada

---

## [2.1.0] - 2026-04-11 - Mensagens Separadas por Plataforma

### ✨ ADICIONADO
- **📱 Mensagens Separadas** - WhatsApp e Telegram têm respostas DIFERENTES
  - Seletor de plataforma na interface (botões WhatsApp/Telegram)
  - Configurações independentes para cada plataforma
  - Filtro automático de mensagens por plataforma

### 🎨 Interface Atualizada
  - Botões de seleção: 📱 WhatsApp (verde) / 🤖 Telegram (azul)
  - Aviso visual: "As mensagens NÃO são as mesmas!"
  - Listas separadas por plataforma

### 🔧 Backend Aprimorado
  - Método `getAutomatedMessagesByPlatform(platform)` no database
  - API aceita parâmetro `platform` nos endpoints
  - Lógica `handleIncomingMessage()` filtra por plataforma

### 📚 Documentação
  - `MENSAGENS_SEPARADAS_IMPLEMENTADO.md` - Detalhes técnicos
  - `MENSAGENS_SEPARADAS_GUIA.md` - Guia rápido
  - README.md atualizado com seção "Mensagens Separadas"

### 🔄 MODIFICADO
- **Database Schema**
  - Campo `platform` obrigatório em `automated_messages`
  - Métodos CRUD atualizados com parâmetro `platform`

- **API Endpoints**
  - `POST /api/automated` - Aceita `platform` no body
  - `PUT /api/automated/:id` - Aceita `platform` no body

- **Frontend (`AutomatedMessages.js`)**
  - Estado `selectedPlatform` para controle
  - Método `handlePlatformChange()` para alternar plataformas
  - Filtro `messages.filter(msg => msg.platform === selectedPlatform)`
  - API calls incluem `platform: selectedPlatform`

- **CSS (`AutomatedMessages.css`)**
  - `.platform-selector` - Container dos botões
  - `.platform-btn.whatsapp.active` - Verde para WhatsApp
  - `.platform-btn.telegram.active` - Azul para Telegram

### ✅ CORRIGIDO
- **Compatibilidade** - Mensagens antigas mantêm `platform = 'whatsapp'`
- **Migração Automática** - Não quebra configurações existentes

---

## [2.0.0] - 2026-04-11 - Integração Telegram Completa

### ✨ ADICIONADO
- **📱 Mensagens Separadas** - WhatsApp e Telegram têm respostas DIFERENTES
  - Seletor de plataforma na interface (botões WhatsApp/Telegram)
  - Configurações independentes para cada plataforma
  - Filtro automático de mensagens por plataforma

- **🎨 Interface Atualizada**
  - Botões de seleção: 📱 WhatsApp (verde) / 🤖 Telegram (azul)
  - Aviso visual: "As mensagens NÃO são as mesmas!"
  - Listas separadas por plataforma

- **🔧 Backend Aprimorado**
  - Método `getAutomatedMessagesByPlatform(platform)` no database
  - API aceita parâmetro `platform` nos endpoints
  - Lógica `handleIncomingMessage()` filtra por plataforma

- **📚 Documentação**
  - `MENSAGENS_SEPARADAS_IMPLEMENTADO.md` - Detalhes técnicos
  - `MENSAGENS_SEPARADAS_GUIA.md` - Guia rápido
  - README.md atualizado com seção "Mensagens Separadas"

### 🔄 MODIFICADO
- **Database Schema**
  - Campo `platform` obrigatório em `automated_messages`
  - Métodos CRUD atualizados com parâmetro `platform`

- **API Endpoints**
  - `POST /api/automated` - Aceita `platform` no body
  - `PUT /api/automated/:id` - Aceita `platform` no body

- **Frontend (`AutomatedMessages.js`)**
  - Estado `selectedPlatform` para controle
  - Método `handlePlatformChange()` para alternar plataformas
  - Filtro `messages.filter(msg => msg.platform === selectedPlatform)`
  - API calls incluem `platform: selectedPlatform`

- **CSS (`AutomatedMessages.css`)**
  - `.platform-selector` - Container dos botões
  - `.platform-btn.whatsapp.active` - Verde para WhatsApp
  - `.platform-btn.telegram.active` - Azul para Telegram

### ✅ CORRIGIDO
- **Compatibilidade** - Mensagens antigas mantêm `platform = 'whatsapp'`
- **Migração Automática** - Não quebra configurações existentes

---

## [2.0.0] - 2026-04-11 - Integração Telegram Completa

### ✨ ADICIONADO
- **🤖 Suporte completo ao Telegram**
  - Múltiplos bots do Telegram via @BotFather
  - Mesmas respostas automáticas para WhatsApp E Telegram
  - Interface unificada com 4 abas

- **🗄️ Novos campos no banco de dados**
  - Tabela `telegram_bots` para configurações
  - Campo `platform` em `chat_history` (whatsapp/telegram)

- **🔧 Novos endpoints API**
  - `GET/POST/PUT/DELETE /api/telegram` - Gerenciamento de bots

- **🎨 Nova interface**
  - Aba "Telegram Bots" com design azul
  - Instruções passo-a-passo para @BotFather
  - Status visual ativo/inativo

- **📚 Documentação**
  - `TELEGRAM_INTEGRACAO.md` - Guia completo
  - `TELEGRAM_IMPLEMENTADO.md` - Resumo técnico
  - README.md atualizado com seções Telegram

### 🔄 MODIFICADO
- **Backend (`server.js`)**
  - `handleIncomingMessage()` suporta múltiplas plataformas
  - Logs diferenciados: `[WHATSAPP]` / `[TELEGRAM]`
  - Inicialização automática de bots do Telegram

- **Frontend (`App.js`)**
  - Título: "WhatsApp & Telegram Bot"
  - Status: "WhatsApp Conectado" / "WhatsApp Desconectado"
  - Nova aba "Telegram Bots"

- **Database (`models/database.js`)**
  - Novos métodos: `addTelegramBot`, `getAllTelegramBots`, etc.
  - Schema atualizado com tabelas Telegram

- **Package.json**
  - Dependência: `node-telegram-bot-api`
  - Scripts de build atualizados

- **Scripts de deploy**
  - `deploy.bat` inclui dependências Telegram
  - Atalhos da área de trabalho atualizados

### 🐛 CORRIGIDO
- Validação de formulário de mensagens automáticas
- Remoção de campo Chat ID obrigatório (agora global)
- Timer de 3 horas implementado corretamente

### 📦 DEPLOY
- Executável único agora suporta WhatsApp + Telegram
- `pkg` configurado com novos assets
- Script de deploy atualizado

---

## [1.5.0] - 2026-04-08 - Otimizações e Deploy

### ✨ ADICIONADO
- **📦 Sistema de deploy completo**
  - `deploy.bat` - Script automático
  - `pkg` para executável standalone
  - `DEPLOY_README.md` - Instruções

- **🎯 Otimizações de resposta**
  - Timer de 3 horas (antes 30 min)
  - Sufixo obrigatório "- RM TECH"
  - Respostas apenas para mensagens habilitadas

- **🖥️ Atalhos da área de trabalho**
  - "Deploy WhatsApp Bot.lnk"
  - "WhatsApp Bot.lnk" (desenvolvimento)

### 🔄 MODIFICADO
- Lógica de resposta mais inteligente
- Interface com confirmações visuais
- Logs mais detalhados no backend

---

## [1.0.0] - 2026-04-07 - Versão Inicial

### ✨ ADICIONADO
- **WhatsApp Web integration**
- **QR Code authentication**
- **Automated responses**
- **Web dashboard**
- **SQLite database**
- **REST API**
- **Global responses with `*`**
- **Client management**
- **Message history**

---

## 📈 Estatísticas da Versão 2.0.0

- **+8 arquivos** criados
- **+150 linhas** de código backend
- **+200 linhas** de código frontend
- **+2 tabelas** no banco de dados
- **+4 endpoints** na API
- **+1 plataforma** suportada (Telegram)
- **+∞ possibilidades** de alcance

## 🎯 Compatibilidade

- ✅ **WhatsApp**: Funciona igual à v1.x
- ✅ **Telegram**: Nova funcionalidade
- ✅ **Database**: Migração automática
- ✅ **API**: Endpoints antigos mantidos
- ✅ **Deploy**: Executável compatível

## 🚀 Próximas Versões

- [ ] Webhooks para notificações
- [ ] Estatísticas e dashboards
- [ ] Templates de resposta
- [ ] Agendamento de mensagens
- [ ] Integração com outras plataformas

---

**🎉 Versão 2.0.0 - Agora com WhatsApp + Telegram!**