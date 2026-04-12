const express = require('express');
const router = express.Router();

// Import the database instance from server.js
let db = null;

function setDatabase(databaseInstance) {
  db = databaseInstance;
}

module.exports = router;
module.exports.setDatabase = setDatabase;

// Get all clients
router.get('/', async (req, res) => {
  try {
    const clients = await db.getAllClients();
    res.json(clients);
  } catch (error) {
    console.error('Error fetching clients:', error);
    res.status(500).json({ error: 'Failed to fetch clients' });
  }
});

// Get chat history for a client
router.get('/:chatId/history', async (req, res) => {
  const { chatId } = req.params;
  const limit = req.query.limit || 50;

  try {
    const history = await db.getChatHistory(chatId, limit);
    res.json(history);
  } catch (error) {
    console.error('Error fetching history:', error);
    res.status(500).json({ error: 'Failed to fetch history' });
  }
});

// Add or update client
router.post('/', async (req, res) => {
  const { chatId, name, phoneNumber } = req.body;

  if (!chatId) {
    return res.status(400).json({ error: 'chatId is required' });
  }

  try {
    const result = await db.addOrUpdateClient(chatId, name, phoneNumber);
    res.json({ success: true, id: result.id });
  } catch (error) {
    console.error('Error adding/updating client:', error);
    res.status(500).json({ error: 'Failed to add/update client' });
  }
});

module.exports = router;
