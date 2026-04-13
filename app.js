#!/usr/bin/env node

/**
 * WhatsApp Bot - Main Application Entry Point
 * For Railway deployment - Both backend API and frontend SPA
 */

const path = require('path');
const fs = require('fs');

// Load environment variables
require('dotenv').config();

// Validate Node.js version
const nodeVersion = parseInt(process.version.split('.')[0].slice(1));
if (nodeVersion < 14) {
  console.error('❌ Node.js 14+ is required');
  process.exit(1);
}

console.log('🚀 WhatsApp Bot - Production Startup');
console.log(`📦 Node version: ${process.version}`);
console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
console.log(`🔌 Port: ${process.env.PORT || 5000}`);
console.log('');

// Set production environment
process.env.NODE_ENV = process.env.NODE_ENV || 'production';

// Start backend server
const serverPath = path.join(__dirname, 'backend', 'server.js');

if (!fs.existsSync(serverPath)) {
  console.error(`❌ Backend server not found at: ${serverPath}`);
  process.exit(1);
}

console.log('📡 Starting backend server...');
require(serverPath);