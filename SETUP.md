# 🚀 Guia de Inicialização - WhatsApp Bot

## ⚠️ Pré-requisito: Instalar Node.js

Antes de executar o projeto, você precisa ter **Node.js** instalado no seu computador.

### Instalação do Node.js

1. Acesse https://nodejs.org/
2. Baixe a versão **LTS (Long Term Support)** - recomendado para produção
3. Execute o instalador e siga os passos:
   - Aceite a licença
   - Escolha o diretório de instalação (padrão é OK)
   - **IMPORTANTE**: Marque a opção "Add to PATH" durante a instalação
   - Continue com as configurações padrão
4. Reinicie seu computador ou terminal para aplicar as mudanças

### Verificar Instalação (no Terminal/PowerShell)

```bash
node --version
npm --version
```

Se ambas retornarem números de versão, a instalação foi bem-sucedida!

---

## 📋 Estrutura do Projeto

Seu projeto encontra-se em: `C:\Users\cauaaa\Documents\whatsapp-bot`

```
whatsapp-bot/
├── backend/           # Servidor Node.js + WhatsApp integration
├── frontend/          # Interface React 
├── README.md          # Documentação completa
└── .gitignore
```

---

## 🎯 Como Executar o Projeto (Após instalar Node.js)

### Método 1: Terminal PowerShell ou CMD

#### Abra dois terminais:

**Terminal 1 - Backend:**
```powershell
cd C:\Users\cauaaa\Documents\whatsapp-bot\backend
npm install
npm start
```

**Terminal 2 - Frontend:**
```powershell
cd C:\Users\cauaaa\Documents\whatsapp-bot\frontend
npm install
npm start
```

### Método 2: Via VS Code

1. Abra o VS Code
2. Abra a pasta: `C:\Users\cauaaa\Documents\whatsapp-bot`
3. Pressione `Ctrl + Shift + `` para abrir o terminal integrado
4. Force o PowerShell ao clicar em "PowerShell"
5. Execute:

```bash
cd backend ; npm install ; npm start
```

6. Abra um novo terminal (Ctrl + Shift + `)
7. Execute:

```bash
cd frontend ; npm install ; npm start
```

---

## ✅ Verificação Após Iniciar

- **Backend**: Verá a mensagem `Server running on port 5000`
- **Frontend**: Abrirá automaticamente `http://localhost:3000` no navegador
- **Status**: A página exibirá "○ Desconectado" (esperado sem estar conectado ao WhatsApp)

---

## 🔗 Usar o Bot

1. **Conectar WhatsApp**:
   - A aba "QR Code" mostrará umcódigo para escanear
   - Use o WhatsApp no celular: Configurações > Aparelhos conectados > Conectar aparelho
   - Aponte a câmera para o QR code

2. **Adicionar Respostas Automáticas**:
   - Vá para "Mensagens Automáticas"
   - Configure palavras-chave e respostas
   - O bot responderá automaticamente quando detectar a palavra-chave

3. **Visualizar Histórico**:
   - Vá para "Clientes"
   - Veja todos os contatos e histórico de mensagens

---

## 🛠️ Troubleshooting

### npm command not found após reinstalar Node.js
- Reinicie o terminal ou computador
- Verifique se selecionou "Add to PATH" durante a instalação

### Porta 5000 já em uso
- Mude a porta no arquivo `backend/.env`
- Altere `PORT=5000` para `PORT=3001` (ou outra disponível)

### Erro ao conectar do WhatsApp
- Verifique sua conexão de internet
- WhatsApp Web deve estar disponível em sua região
- Teste em https://web.whatsapp.com no navegador primeiro

### Banco de dados corrompido
- Delete o arquivo `whatsapp_bot.db` na raiz do projeto
- Reinicie o backend

---

## 📚 Documentação Completa

Para mais informações, veja `README.md` no diretório raiz do projeto.

---

**Dúvidas? Verifique se Node.js está instalado corretamente rodando `node --version` e `npm --version` no terminal!**
