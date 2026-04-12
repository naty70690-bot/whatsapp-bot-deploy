import React, { useState, useEffect, useCallback } from 'react';
import axios from 'axios';
import './QRPanel.css';

function QRPanel({ isClientReady }) {
  const [qrCode, setQrCode] = useState(null);
  const [loading, setLoading] = useState(true);
  const [status, setStatus] = useState('initializing');
  const [lastUpdate, setLastUpdate] = useState(Date.now());

  const fetchQR = useCallback(async () => {
    try {
      const startTime = Date.now();
      const response = await axios.get('/api/qr', {
        timeout: 5000,
        headers: {
          'Cache-Control': 'no-cache'
        }
      });

      const fetchTime = Date.now() - startTime;
      console.log(`QR fetch took ${fetchTime}ms`);

      setStatus(response.data.status || 'unknown');
      setLastUpdate(Date.now());

      if (response.data.qr) {
        setQrCode(response.data.qr);
        setLoading(false);
      } else if (response.data.ready) {
        setLoading(false);
      }
    } catch (error) {
      console.error('Error fetching QR code:', error);
      setStatus('error');
      // Retry faster on error
      setTimeout(fetchQR, 1000);
    }
  }, []);

  useEffect(() => {
    if (!isClientReady) {
      // Initial fetch
      fetchQR();

      // Poll for updates - faster initially, then slower
      let intervalTime = 1000; // Start with 1 second
      const interval = setInterval(() => {
        fetchQR();
        // Gradually increase interval time up to 3 seconds
        if (intervalTime < 3000) {
          intervalTime += 500;
        }
      }, intervalTime);

      return () => clearInterval(interval);
    } else {
      setLoading(false);
      setStatus('connected');
    }
  }, [isClientReady, fetchQR]);

  const getStatusMessage = () => {
    switch (status) {
      case 'connected':
        return 'Conectado ao WhatsApp!';
      case 'qr_available':
        return 'Código QR gerado. Escaneie com o WhatsApp.';
      case 'initializing':
        return 'Inicializando WhatsApp...';
      case 'starting':
        return 'Iniciando conexão...';
      case 'error':
        return 'Erro ao conectar. Tentando novamente...';
      default:
        return 'Aguardando conexão...';
    }
  };

  const getStatusColor = () => {
    switch (status) {
      case 'connected':
        return '#4caf50';
      case 'qr_available':
        return '#2196f3';
      case 'error':
        return '#f44336';
      default:
        return '#ff9800';
    }
  };

  return (
    <div className="qr-panel">
      <div className="qr-content">
        <h2>Conectar WhatsApp</h2>

        <div className="status-display" style={{ color: getStatusColor() }}>
          <div className="status-indicator">
            {status === 'connected' ? '✓' : status === 'error' ? '⚠' : '⟳'}
          </div>
          <p className="status-text">{getStatusMessage()}</p>
          <small className="last-update">
            Última atualização: {new Date(lastUpdate).toLocaleTimeString()}
          </small>
        </div>

        {isClientReady ? (
          <div className="qr-success">
            <div className="success-icon">✅</div>
            <p><strong>Conectado com sucesso!</strong></p>
            <p className="info-text">O bot está ativo e responderá mensagens automaticamente.</p>
            <div className="connection-info">
              <small>💡 Dica: Você pode fechar esta janela. O bot continuará funcionando em segundo plano.</small>
            </div>
          </div>
        ) : qrCode ? (
          <>
            <p className="qr-instructions">
              Escaneie o código QR abaixo com o WhatsApp:
            </p>
            <ol className="qr-steps">
              <li>Abra o WhatsApp no seu telefone</li>
              <li>Vá para <strong>Configurações</strong> → <strong>Aparelhos conectados</strong></li>
              <li>Toque em <strong>Conectar aparelho</strong></li>
              <li>Aponte a câmera para o código QR abaixo</li>
            </ol>

            <div className="qr-display">
              <img
                src={qrCode}
                alt="WhatsApp QR Code"
                className="qr-image"
                onError={() => {
                  console.log('QR image failed to load, retrying...');
                  setTimeout(fetchQR, 500);
                }}
              />
              <p className="qr-expiry">Este código expira em 45 segundos</p>
            </div>
          </>
        ) : loading ? (
          <div className="qr-loading">
            <div className="loading-spinner"></div>
            <p>Gerando código QR...</p>
            <small>Isso pode levar alguns segundos na primeira vez</small>
          </div>
        ) : (
          <div className="qr-error">
            <p>Não foi possível gerar o código QR.</p>
            <button onClick={fetchQR} className="retry-btn">
              Tentar Novamente
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

export default QRPanel;
