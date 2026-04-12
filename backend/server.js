const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Variables
let whatsappClient = null;
let isClientReady = false;
let qrCodeData = null;
let qrCodeGenerated = false;
let automatedMessages = [];
let lastQrGeneration = 0;
const QR_CACHE_TIME = 30000; // 30 seconds cache for QR codes

// Initialize Database
const Database = require('./models/database');
const db = new Database();

// Initialize WhatsApp Client
function initWhatsApp() {
  console.log('Initializing WhatsApp client...');

  whatsappClient = new Client({
    authStrategy: new LocalAuth({
      clientId: 'whatsapp-bot-client',
      dataPath: path.join(__dirname, '.wwebjs_auth')
    }),
    puppeteer: {
      headless: true,
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--no-first-run',
        '--no-zygote',
        '--single-process',
        '--disable-gpu'
      ]
    },
    webVersionCache: {
      type: 'remote',
      remotePath: 'https://raw.githubusercontent.com/wppconnect-team/wa-version/main/html/2.2412.54.html',
    }
  });

  // QR Code event - Optimized
  whatsappClient.on('qr', (qr) => {
    console.log('QR Code received - Generating optimized QR...');
    const now = Date.now();

    // Only regenerate QR if cache expired or first time
    if (!qrCodeGenerated || (now - lastQrGeneration) > QR_CACHE_TIME) {
      qrcode.toDataURL(qr, {
        errorCorrectionLevel: 'M',
        type: 'image/png',
        quality: 0.92,
        margin: 1,
        color: {
          dark: '#000000',
          light: '#FFFFFF'
        }
      }, (err, url) => {
        if (err) {
          console.error('Error generating QR code:', err);
          return;
        }
        qrCodeData = url;
        qrCodeGenerated = true;
        lastQrGeneration = now;
        console.log('QR Code generated successfully (optimized)');
      });
    } else {
      console.log('Using cached QR code');
    }
  });

  // Ready event - Optimized
  whatsappClient.on('ready', () => {
    console.log('WhatsApp client is ready! ✅');
    isClientReady = true;
    qrCodeData = null;
    qrCodeGenerated = false;

    // Get and display bot info
    whatsappClient.getState().then(state => {
      console.log(`Bot state: ${state}`);
    });

    whatsappClient.info && console.log(`Bot info: ${whatsappClient.info.wid.user}`);
  });

  // Authenticated event
  whatsappClient.on('authenticated', () => {
    console.log('WhatsApp client authenticated successfully! 🔐');
  });

  // Auth failure event
  whatsappClient.on('auth_failure', (msg) => {
    console.error('Authentication failed:', msg);
    isClientReady = false;
    qrCodeData = null;
    qrCodeGenerated = false;
  });

  // Loading screen event
  whatsappClient.on('loading_screen', (percent, message) => {
    console.log(`Loading: ${percent}% - ${message}`);
  });

  // Message received event
  whatsappClient.on('message', (message) => {
    console.log(`Message received from ${message.from}: ${message.body}`);
    handleIncomingMessage(message);
  });

  // Disconnected event - With auto-reconnect
  whatsappClient.on('disconnected', (reason) => {
    console.log('WhatsApp client disconnected:', reason);
    isClientReady = false;
    qrCodeData = null;
    qrCodeGenerated = false;

    // Auto-reconnect after 5 seconds
    console.log('Attempting to reconnect in 5 seconds...');
    setTimeout(() => {
      console.log('Reconnecting WhatsApp client...');
      initWhatsApp();
    }, 5000);
  });

  whatsappClient.initialize();
}

function formatBotMessage(messageText) {
  const suffix = ' - RM TECH';
  if (!messageText) return suffix.trim();
  if (messageText.toLowerCase().endsWith(suffix.toLowerCase())) {
    return messageText;
  }
  return `${messageText.trim()}${suffix}`;
}

// Handle incoming messages
async function handleIncomingMessage(message) {
  const chatId = message.from;
  const messageBody = message.body || '';

  console.log(`[WHATSAPP] Mensagem recebida de ${chatId}: ${messageBody}`);

  // Save incoming message to history
  await db.addChatHistory(chatId, messageBody, 'text', false);

  // Check if bot already responded recently (within 3 hours)
  const lastBotResponse = await db.getLastBotResponse(chatId, 180);
  if (lastBotResponse) {
    console.log(`[WHATSAPP] ⏸️  Já respondemos para este contato em: ${lastBotResponse.created_at}. Ignorando...`);
    return;
  }

  // Get ALL enabled automated responses
  const automatedResponse = (await db.getAllAutomatedMessages()).filter(msg => msg.enabled);

  if (automatedResponse.length === 0) {
    console.log(`[WHATSAPP] Nenhuma resposta automática configurada`);
    return;
  }

  console.log(`[WHATSAPP] Verificando ${automatedResponse.length} respostas automáticas`);

  // Try to find a response (any trigger match)
  for (const auto of automatedResponse) {
    // Se trigger é "*", responde tudo
    if (auto.trigger.toLowerCase() === '*') {
      const botResponse = formatBotMessage(auto.response);
      console.log(`[WHATSAPP] ✅ Respondendo com: ${botResponse}`);

      await db.addChatHistory(chatId, botResponse, 'text', true);
      setTimeout(() => {
        whatsappClient.sendMessage(chatId, botResponse);
      }, 500);
      return;
    }

    // Se a mensagem contém a palavra-chave
    if (messageBody.toLowerCase().includes(auto.trigger.toLowerCase())) {
      const botResponse = formatBotMessage(auto.response);
      console.log(`[WHATSAPP] ✅ Respondendo com: ${botResponse}`);

      await db.addChatHistory(chatId, botResponse, 'text', true);
      setTimeout(() => {
        whatsappClient.sendMessage(chatId, botResponse);
      }, 500);
      return;
    }
  }

  console.log(`[WHATSAPP] Nenhuma resposta correspondeu`);
}

// Routes
const automatedRouter = require('./routes/automated');
const clientRouter = require('./routes/client');

// Set database instance for routes
automatedRouter.setDatabase(db);
clientRouter.setDatabase(db);

app.use('/api/automated', automatedRouter);
app.use('/api/client', clientRouter);

// QR Code endpoint - Optimized
app.get('/api/qr', (req, res) => {
  res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate');
  res.setHeader('Pragma', 'no-cache');
  res.setHeader('Expires', '0');

  if (isClientReady) {
    // Already connected - return ready status immediately
    return res.json({
      qr: null,
      ready: true,
      status: 'connected',
      timestamp: Date.now()
    });
  }

  if (qrCodeData) {
    // QR available - return it immediately
    return res.json({
      qr: qrCodeData,
      ready: false,
      status: 'qr_available',
      timestamp: Date.now()
    });
  }

  // No QR yet - check if client is initializing
  if (whatsappClient) {
    return res.json({
      qr: null,
      ready: false,
      status: 'initializing',
      timestamp: Date.now()
    });
  }

  // Client not initialized - initialize it
  console.log('Client not ready, initializing...');
  initWhatsApp();

  return res.json({
    qr: null,
    ready: false,
    status: 'starting',
    timestamp: Date.now()
  });
});

// Status endpoint - Enhanced
app.get('/api/status', (req, res) => {
  const status = {
    isClientReady,
    qrCodeAvailable: qrCodeData !== null,
    qrGenerated: qrCodeGenerated,
    lastQrGeneration: lastQrGeneration,
    timestamp: Date.now(),
    uptime: process.uptime(),
    memory: process.memoryUsage()
  };

  if (isClientReady && whatsappClient && whatsappClient.info) {
    status.botInfo = {
      wid: whatsappClient.info.wid,
      pushname: whatsappClient.info.pushname,
      platform: whatsappClient.info.platform
    };
  }

  res.json(status);
});

// Send message endpoint
app.post('/api/send-message', async (req, res) => {
  const { phoneNumber, message } = req.body;

  if (!isClientReady) {
    return res.status(400).json({ error: 'WhatsApp client is not ready' });
  }

  if (!phoneNumber || !message) {
    return res.status(400).json({ error: 'Phone number and message are required' });
  }

  try {
    const chatId = `${phoneNumber}@c.us`;
    const formattedMessage = formatBotMessage(message);
    await whatsappClient.sendMessage(chatId, formattedMessage);
    res.json({ success: true, message: 'Message sent' });
  } catch (error) {
    console.error('Error sending message:', error);
    res.status(500).json({ error: 'Failed to send message', details: error.message });
  }
});

// Start server
app.listen(PORT, async () => {
  console.log(`Server running on port ${PORT}`);
  await db.init();
  initWhatsApp();
});

module.exports = app;
