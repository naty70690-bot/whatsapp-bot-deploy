# 🤖 Integração com Telegram

## Visão Geral

O bot agora suporta **WhatsApp E Telegram** simultaneamente! Configure bots do Telegram para responder automaticamente mensagens da mesma forma que funciona no WhatsApp.

## 🚀 Como Configurar

### 1. Criar um Bot no Telegram

1. **Abra o Telegram** no seu telefone ou computador
2. **Procure por** `@BotFather`
3. **Envie a mensagem**: `/newbot`
4. **Siga as instruções**:
   - Digite um nome para seu bot
   - Digite um username (deve terminar com "bot")
5. **BotFather vai te dar um TOKEN** - copie ele!

### 2. Configurar no Painel

1. **Abra o painel web**: `http://localhost:3000`
2. **Vá para a aba** "Telegram Bots"
3. **Clique em** "Novo Bot do Telegram"
4. **Preencha**:
   - **Token do Bot**: Cole o token do BotFather
   - **Nome de Usuário**: O username do seu bot (opcional)
5. **Clique em** "Adicionar Bot"

### 3. Configurar Respostas Automáticas

As **mesmas respostas** configuradas para WhatsApp funcionam para Telegram!

- Use `*` para responder QUALQUER mensagem
- Configure palavras-chave específicas
- Ative/desative respostas individualmente

## 📱 Como Funciona

### WhatsApp
- Conecta via QR Code
- Responde mensagens automaticamente
- Timer de 3 horas entre respostas

### Telegram
- Conecta via Token do BotFather
- Responde mensagens automaticamente
- **Mesmo timer de 3 horas**
- Suporte a múltiplos bots

## 🎯 Exemplos de Uso

### Exemplo 1: Responder Tudo
```
Palavra-chave: *
Resposta: Olá! Obrigado por entrar em contato. Responderemos em breve.
```
→ Responde QUALQUER mensagem no WhatsApp E Telegram

### Exemplo 2: Suporte Técnico
```
Palavra-chave: suporte
Resposta: Nossa equipe de suporte entrará em contato em até 24h.
```
→ Responde apenas mensagens contendo "suporte"

### Exemplo 3: Vendas
```
Palavra-chave: preço
Resposta: Nossos preços começam em R$ 99,90. Entre em contato para mais detalhes!
```
→ Responde apenas mensagens contendo "preço"

## ⚙️ Funcionalidades Avançadas

### Múltiplos Bots
- Configure **quantos bots quiser**
- Cada bot pode ter respostas diferentes
- Ative/desative individualmente

### Timer Inteligente
- **Não responde repetidamente** na mesma conversa
- **3 horas** de intervalo mínimo
- **Funciona igual** no WhatsApp e Telegram

### Histórico Completo
- Todas as mensagens são salvas
- Visualize histórico por plataforma
- Dados separados para WhatsApp e Telegram

## 🔧 Resolução de Problemas

### Bot não responde no Telegram
1. Verifique se o token está correto
2. Certifique-se de que o bot está "Ativo"
3. Teste enviando `/start` para o bot

### Mensagens duplicadas
- Sistema previne respostas duplicadas automaticamente
- Timer de 3 horas evita spam

### Bot não conecta
- Token incorreto do BotFather
- Bot bloqueado/desativado
- Problemas de rede

## 📊 Logs e Monitoramento

O sistema mostra logs detalhados:

```
[TELEGRAM] Mensagem recebida de 123456789: Olá
[TELEGRAM] ✅ Respondendo com: Olá! Como posso ajudar?
```

```
[WHATSAPP] Mensagem recebida de 5511999999999: Oi
[WHATSAPP] ⏸️ Já respondemos para este contato em: 2024-01-08 14:30:00. Ignorando...
```

## 🎉 Benefícios

✅ **Duas plataformas** com uma configuração só
✅ **Alcance maior** - WhatsApp + Telegram
✅ **Mesmo sistema** - não precisa aprender duas interfaces
✅ **Backup automático** - se uma plataforma cair, a outra funciona
✅ **Custo zero** - bots do Telegram são gratuitos

## 📞 Suporte

Para criar bots do Telegram:
- **BotFather**: @BotFather no Telegram
- **Documentação**: https://core.telegram.org/bots

Para suporte técnico do sistema:
- Verifique os logs no terminal
- Certifique-se de que o backend está rodando
- Teste as conexões individualmente

---

**🚀 Pronto para dominar WhatsApp E Telegram!**