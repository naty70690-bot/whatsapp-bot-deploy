# 🔥 Resposta Automática para Qualquer Mensagem

## Como Configurar

Agora seu bot pode responder **AUTOMATICAMENTE** a QUALQUER pessoa que enviar mensagem!

### Opção 1: Responder a Palavra-Chave Específica

Entre com uma palavra ou frase na aba "Mensagens Automáticas":

```
Chat ID:      5511999999999
Palavra-chave: olá
Resposta:     Olá! Como posso ajudar?
```

✅ O bot responderá apenas quando alguém disser "olá"

---

### Opção 2: Responder a QUALQUER Mensagem 🎯

Digite `*` (um asterisco) como palavra-chave:

```
Chat ID:      5511999999999
Palavra-chave: *
Resposta:     Obrigado por sua mensagem! Responderemos em breve.
```

✅ O bot responderá a **QUALQUER** mensagem que receber!

---

## 🎯 Exemplos Práticos

### Exemplo 1: Atendimento Automático
```
Chat ID:      5521987654321
Palavra-chave: *
Resposta:     
Olá! 👋
Obrigado por entrar em contato.
Estamos analisando sua mensagem e retornaremos em breve.
```

### Exemplo 2: Combinado (Específico + Global)
```
Message 1:
Chat ID:      5521987654321
Palavra-chave: oi
Resposta:     Oi! Bem-vindo! 😊

Message 2:
Chat ID:      5521987654321
Palavra-chave: *
Resposta:     Mensagem recebida! Obrigado!
```

**Funcionamento:**
- Se disser "oi" → Recebe: "Oi! Bem-vindo! 😊"
- Se disser qualquer outra coisa → Recebe: "Mensagem recebida! Obrigado!"

---

## 📋 Ordem de Precedência

1. **Primeiro**: Procura por resposta com a palavra-chave exata
2. **Depois**: Se não encontrar, procura por resposta global (`*`)
3. **Nada**: Se não houver nenhuma, não responde

---

## 🎨 Visual no Painel

Quando você criar uma resposta com `*`, ela aparecerá assim:

```
┌─────────────────────────────────────┐
│ Chat ID: 5511999999999              │
├─────────────────────────────────────┤
│ Palavra-chave: ✓ QUALQUER MENSAGEM  │ ← Verde, destaque especial
│ Resposta: Obrigado!, sua mensagem...│
├─────────────────────────────────────┤
│ ✏️ Editar  🗑️ Deletar              │
└─────────────────────────────────────┘
```

---

## 💡 Dicas Úteis

✅ **Use `*` para respostas genéricas**
```
* = Olá! Obrigado por nos contact. Responderemos em breve!
```

✅ **Use palavras-chave específicas para respostas direcionadas**
```
help = Aqui estão nossas opções: 1. Faturamento 2. Suporte...
```

✅ **Combine ambas as estratégias**
```
Específicas: "hora", "endereço", "telefone", "preço"
Global (*): Uma resposta padrão para qualquer coisa
```

✅ **Responda em até 1 segundo**
O bot aguarda 500ms antes de responder (para parecer natural)

✅ **Customize a resposta**
Você pode usar quebras de linha e emojis! 🚀

---

## ⚙️ Diferentes Triggers Aceitos

Todos esses funcionarão como "global" (responder tudo):
- `*` ← **Recomendado**
- `qualquer`
- qualquer palavra mesmo

Mas `*` é a mais clara e recomendada!

---

## 🔄 Editar Respostas

1. Na aba "Mensagens Automáticas"
2. Clique no botão **✏️ Editar**
3. Modifique a resposta
4. Clique **Atualizar Mensagem**

---

## ⏸️ Desabilitar Temporariamente

Clique no botão **✓** (círculo) ao lado de cada mensagem para:
- ✓ Verde = Ativado (respondendo)
- ○ Laranja = Desativado (não responde)

---

## 🗑️ Deletar Respostas

1. Clique no botão **🗑️ Deletar**
2. Confirme a ação
3. Pronto! A resposta foi removida

---

## ❌ Resolvendo Problemas

| Problema | Solução |
|----------|---------|
| Bot não responde | Verifique se está "Conectado" (verde no topo) |
| Responde a tudo menos `*` | Reinicie o backend (`npm start`) |
| Quer desativar `*` temporariamente | Clique no botão ✓ para desabilitar |
| Quer múltiplas respostas automáticas | Use triggers diferentes (oi, olá, help, etc) |

---

## 🚀 Exemplo Completo

**Cenário**: Você quer um atendimento 24/7

1. **Configure uma resposta global:**
   ```
   Chat ID: 5511999999999
   Palavra-chave: *
   Resposta:
   Olá! 👋 Obrigado por sua mensagem.
   
   Nosso horário de atendimento:
   🕐 Segunda a Sexta: 09h às 18h
   
   Responderemos em breve!
   ```

2. **Adicione respostas específicas (opcional):**
   ```
   Palavra-chave: preço
   Resposta: Nosso produto custa R$ 99,90
   
   Palavra-chave: endereço
   Resposta: Rua das Flores, 123 - São Paulo, SP
   ```

3. **Resultado:**
   - Mensagem: "Oi" → Resposta: resposta global
   - Mensagem: "Qual é o preço?" → Resposta: resposta de preço (mais específica!)
   - Mensagem: "Olá!" → Resposta: resposta global
   - Mensagem: Qualquer coisa → Resposta: resposta global

---

**Pronto! Agora seu bot responde a QUALQUER mensagem! 🤖✨**
