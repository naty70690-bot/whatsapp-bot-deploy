const sqlite3 = require('sqlite3').verbose();
const path = require('path');

class Database {
  constructor() {
    this.db = null;
    this.dbPath = path.join(__dirname, '../../whatsapp_bot.db');
  }

  init() {
    return new Promise((resolve, reject) => {
      this.db = new sqlite3.Database(this.dbPath, (err) => {
        if (err) {
          console.error('Error opening database:', err);
          reject(err);
        } else {
          console.log('Connected to SQLite database');
          this.createTables();
          resolve();
        }
      });
    });
  }

  createTables() {
    // Automated Messages Table
    this.db.run(`
      CREATE TABLE IF NOT EXISTS automated_messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chat_id TEXT NOT NULL,
        trigger TEXT NOT NULL,
        response TEXT NOT NULL,
        enabled BOOLEAN DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Chat History Table
    this.db.run(`
      CREATE TABLE IF NOT EXISTS chat_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chat_id TEXT NOT NULL,
        message_body TEXT NOT NULL,
        message_type TEXT,
        is_from_bot BOOLEAN DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Clients Table
    this.db.run(`
      CREATE TABLE IF NOT EXISTS clients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chat_id TEXT UNIQUE NOT NULL,
        name TEXT,
        phone_number TEXT,
        last_interaction DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);
  }

  // Automated Messages Methods
  addAutomatedMessage(chatId, trigger, response) {
    return new Promise((resolve, reject) => {
      const sql = 'INSERT INTO automated_messages (chat_id, trigger, response) VALUES (?, ?, ?)';
      this.db.run(sql, [chatId, trigger, response], function(err) {
        if (err) {
          reject(err);
        } else {
          resolve({ id: this.lastID });
        }
      });
    });
  }

  getAutomatedMessages(chatId) {
    return new Promise((resolve, reject) => {
      const sql = 'SELECT * FROM automated_messages WHERE chat_id = ? AND enabled = 1';
      this.db.all(sql, [chatId], (err, rows) => {
        if (err) {
          reject(err);
        } else {
          resolve(rows || []);
        }
      });
    });
  }

  getAllAutomatedMessages() {
    return new Promise((resolve, reject) => {
      const sql = 'SELECT * FROM automated_messages ORDER BY created_at DESC';
      this.db.all(sql, (err, rows) => {
        if (err) {
          reject(err);
        } else {
          resolve(rows || []);
        }
      });
    });
  }

  updateAutomatedMessage(id, trigger, response, enabled) {
    return new Promise((resolve, reject) => {
      const sql = 'UPDATE automated_messages SET trigger = ?, response = ?, enabled = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?';
      this.db.run(sql, [trigger, response, enabled ? 1 : 0, id], function(err) {
        if (err) {
          reject(err);
        } else {
          resolve({ changes: this.changes });
        }
      });
    });
  }

  deleteAutomatedMessage(id) {
    return new Promise((resolve, reject) => {
      const sql = 'DELETE FROM automated_messages WHERE id = ?';
      this.db.run(sql, [id], function(err) {
        if (err) {
          reject(err);
        } else {
          resolve({ changes: this.changes });
        }
      });
    });
  }

  // Chat History Methods
  addChatHistory(chatId, messageBody, messageType = 'text', isFromBot = false) {
    return new Promise((resolve, reject) => {
      const sql = 'INSERT INTO chat_history (chat_id, message_body, message_type, is_from_bot) VALUES (?, ?, ?, ?)';
      this.db.run(sql, [chatId, messageBody, messageType, isFromBot ? 1 : 0], function(err) {
        if (err) {
          reject(err);
        } else {
          resolve({ id: this.lastID });
        }
      });
    });
  }

  getChatHistory(chatId, limit = 50) {
    return new Promise((resolve, reject) => {
      const sql = 'SELECT * FROM chat_history WHERE chat_id = ? ORDER BY created_at DESC LIMIT ?';
      this.db.all(sql, [chatId, limit], (err, rows) => {
        if (err) {
          reject(err);
        } else {
          resolve((rows || []).reverse());
        }
      });
    });
  }

  // Check if bot responded recently (within minutes)
  getLastBotResponse(chatId, minutesBack = 30) {
    return new Promise((resolve, reject) => {
      const sql = `SELECT * FROM chat_history 
                   WHERE chat_id = ? AND is_from_bot = 1 
                   AND created_at > datetime('now', '-' || ? || ' minutes')
                   ORDER BY created_at DESC LIMIT 1`;
      this.db.get(sql, [chatId, minutesBack], (err, row) => {
        if (err) {
          reject(err);
        } else {
          resolve(row || null);
        }
      });
    });
  }

  close() {
    return new Promise((resolve, reject) => {
      this.db.close((err) => {
        if (err) {
          reject(err);
        } else {
          resolve();
        }
      });
    });
  }
}

module.exports = Database;
