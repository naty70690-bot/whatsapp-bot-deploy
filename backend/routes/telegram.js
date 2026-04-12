const express = require('express');
const router = express.Router();
const Database = require('../models/database');

const db = new Database();
db.init();

// Get all Telegram bots
router.get('/', async (req, res) => {
  try {
    const bots = await db.getAllTelegramBots();
    res.json(bots);
  } catch (error) {
    console.error('Error fetching Telegram bots:', error);
    res.status(500).json({ error: 'Failed to fetch Telegram bots' });
  }
});

// Add new Telegram bot
router.post('/', async (req, res) => {
  const { botToken, botUsername } = req.body;

  if (!botToken) {
    return res.status(400).json({ error: 'Bot token is required' });
  }

  try {
    const result = await db.addTelegramBot(botToken, botUsername || null);
    res.status(201).json({ success: true, id: result.id });
  } catch (error) {
    console.error('Error adding Telegram bot:', error);
    res.status(500).json({ error: 'Failed to add Telegram bot' });
  }
});

// Update Telegram bot
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { botToken, botUsername, enabled } = req.body;

  if (!botToken || enabled === undefined) {
    return res.status(400).json({ error: 'Bot token and enabled status are required' });
  }

  try {
    const result = await db.updateTelegramBot(id, botToken, botUsername, enabled);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Telegram bot not found' });
    }
    res.json({ success: true, changes: result.changes });
  } catch (error) {
    console.error('Error updating Telegram bot:', error);
    res.status(500).json({ error: 'Failed to update Telegram bot' });
  }
});

// Delete Telegram bot
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.deleteTelegramBot(id);
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Telegram bot not found' });
    }
    res.json({ success: true, changes: result.changes });
  } catch (error) {
    console.error('Error deleting Telegram bot:', error);
    res.status(500).json({ error: 'Failed to delete Telegram bot' });
  }
});

module.exports = router;