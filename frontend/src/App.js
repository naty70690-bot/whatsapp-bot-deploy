import React, { useState, useEffect } from 'react';
import axios from 'axios';
import QRPanel from './components/QRPanel';
import AutomatedMessages from './components/AutomatedMessages';
import ClientsList from './components/ClientsList';
import './App.css';

function App() {
  const [activeTab, setActiveTab] = useState('qr');
  const [isClientReady, setIsClientReady] = useState(false);

  useEffect(() => {
    const checkStatus = async () => {
      try {
        const response = await axios.get('/api/status');
        setIsClientReady(response.data.isClientReady);
      } catch (error) {
        console.error('Error checking status:', error);
      }
    };

    const interval = setInterval(checkStatus, 2000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>🤖 WhatsApp Bot</h1>
        <p>Respostas Automáticas para WhatsApp</p>
        <div className={`status-indicator ${isClientReady ? 'ready' : 'not-ready'}`}>
          {isClientReady ? '✓ WhatsApp Conectado' : '○ WhatsApp Desconectado'}
        </div>
      </header>

      <nav className="app-nav">
        <button
          className={`nav-button ${activeTab === 'qr' ? 'active' : ''}`}
          onClick={() => setActiveTab('qr')}
        >
          QR Code
        </button>
        <button
          className={`nav-button ${activeTab === 'messages' ? 'active' : ''}`}
          onClick={() => setActiveTab('messages')}
          disabled={!isClientReady}
        >
          Mensagens Automáticas
        </button>
        <button
          className={`nav-button ${activeTab === 'clients' ? 'active' : ''}`}
          onClick={() => setActiveTab('clients')}
          disabled={!isClientReady}
        >
          Clientes
        </button>
      </nav>

      <main className="app-content">
        {activeTab === 'qr' && <QRPanel isClientReady={isClientReady} />}
        {activeTab === 'messages' && isClientReady && <AutomatedMessages />}
        {activeTab === 'clients' && isClientReady && <ClientsList />}
      </main>
    </div>
  );
}

export default App;
