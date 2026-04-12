import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ClientsList.css';

function ClientsList() {
  const [clients, setClients] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedClient, setSelectedClient] = useState(null);
  const [chatHistory, setChatHistory] = useState([]);

  useEffect(() => {
    fetchClients();
  }, []);

  const fetchClients = async () => {
    try {
      const response = await axios.get('/api/client');
      setClients(response.data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching clients:', error);
      setLoading(false);
    }
  };

  const handleSelectClient = async (client) => {
    setSelectedClient(client);
    try {
      const response = await axios.get(`/api/client/${client.chat_id}/history`);
      setChatHistory(response.data);
    } catch (error) {
      console.error('Error fetching chat history:', error);
    }
  };

  return (
    <div className="clients-container">
      <h2>Clientes</h2>

      <div className="clients-content">
        <div className="clients-list">
          <h3>Lista de Clientes</h3>
          {loading ? (
            <p className="loading-text">Carregando...</p>
          ) : clients.length === 0 ? (
            <p className="no-clients">Nenhum cliente registrado</p>
          ) : (
            <div className="client-items">
              {clients.map(client => (
                <div
                  key={client.id}
                  className={`client-item ${selectedClient?.id === client.id ? 'selected' : ''}`}
                  onClick={() => handleSelectClient(client)}
                >
                  <div className="client-info">
                    <p className="client-name">{client.name || 'Sem nome'}</p>
                    <p className="client-phone">{client.phone_number || client.chat_id}</p>
                  </div>
                  <small className="client-date">
                    {new Date(client.last_interaction).toLocaleDateString('pt-BR')}
                  </small>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="chat-history">
          {selectedClient ? (
            <>
              <h3>Histórico: {selectedClient.name || 'Sem nome'}</h3>
              {chatHistory.length === 0 ? (
                <p className="no-history">Nenhuma mensagem neste chat</p>
              ) : (
                <div className="history-messages">
                  {chatHistory.map(msg => (
                    <div key={msg.id} className={`history-message ${msg.is_from_bot ? 'bot' : 'user'}`}>
                      <div className="message-sender">
                        {msg.is_from_bot ? '🤖 Bot' : '👤 Cliente'}
                      </div>
                      <div className="message-text">{msg.message_body}</div>
                      <small className="message-time">
                        {new Date(msg.created_at).toLocaleString('pt-BR')}
                      </small>
                    </div>
                  ))}
                </div>
              )}
            </>
          ) : (
            <div className="no-client-selected">
              <p>Selecione um cliente para ver o histórico de chat</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default ClientsList;
