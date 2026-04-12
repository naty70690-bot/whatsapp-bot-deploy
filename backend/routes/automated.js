const express = require('express');
const router = express.Router();

// Import the database instance from server.js
let db = null;

function setDatabase(databaseInstance) {
  db = databaseInstance;
}

module.exports = router;
module.exports.setDatabase = setDatabase;

// Get all automated messages
router.get('/', async (req, res) => {
  try {
    const messages = await db.getAllAutomatedMessages();
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages:', error);
    res.status(500).json({ error: 'Failed to fetch messages' });
  }
});

// Get automated messages for a specific chat
router.get('/:chatId', async (req, res) => {
  const { chatId } = req.params;
  try {
    const messages = await db.getAutomatedMessages(chatId);
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages:', error);
    res.status(500).json({ error: 'Failed to fetch messages' });
  }
});

// Add new automated message
router.post('/', async (req, res) => {
  const { trigger, response } = req.body;
  const chatId = 'global'; // Chat ID genérico para QUALQUER pessoa

  if (!trigger || !response) {
    return res.status(400).json({ error: 'Missing required fields: trigger, response' });
  }

  try {
    const result = await db.addAutomatedMessage(chatId, trigger, response);
    res.status(201).json({ success: true, id: result.id });
  } catch (error) {
    console.error('Error adding message:', error);
    res.status(500).json({ error: 'Failed to add message' });
  }
});

// Update automated message
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { trigger, response, enabled } = req.body;

  if (!trigger || !response || enabled === undefined) {
    return res.status(400).json({ error: 'Missing required fields: trigger, response, enabled' });
  }

  try {
    const result = await db.updateAutomatedMessage(id, trigger, response, enabled);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Message not found' });
    }
    res.json({ success: true, changes: result.changes });
  } catch (error) {
    console.error('Error updating message:', error);
    res.status(500).json({ error: 'Failed to update message' });
  }
});

// Delete automated message
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.deleteAutomatedMessage(id);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Message not found' });
    }
    res.json({ success: true, changes: result.changes });
  } catch (error) {
    console.error('Error deleting message:', error);
    res.status(500).json({ error: 'Failed to delete message' });
  }
});

module.exports = router;
