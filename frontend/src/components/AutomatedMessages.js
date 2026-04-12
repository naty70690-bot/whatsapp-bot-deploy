import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './AutomatedMessages.css';

function AutomatedMessages() {
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [formData, setFormData] = useState({
    trigger: '',
    response: ''
  });
  const [editing, setEditing] = useState(null);

  useEffect(() => {
    fetchMessages();
  }, []);

  const fetchMessages = async () => {
    try {
      const response = await axios.get('/api/automated');
      setMessages(response.data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching messages:', error);
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!formData.trigger || !formData.response) {
      alert('Por favor, preencha todos os campos');
      return;
    }

    try {
      if (editing) {
        await axios.put(`/api/automated/${editing.id}`, {
          trigger: formData.trigger,
          response: formData.response,
          enabled: editing.enabled
        });
      } else {
        await axios.post('/api/automated', {
          trigger: formData.trigger,
          response: formData.response
        });
      }
      
      setFormData({ trigger: '', response: '' });
      setEditing(null);
      fetchMessages();
    } catch (error) {
      console.error('Error saving message:', error);
      alert('Erro ao salvar mensagem');
    }
  };

  const handleEdit = (message) => {
    setEditing(message);
    setFormData({
      trigger: message.trigger,
      response: message.response
    });
  };

  const handleDelete = async (id) => {
    if (window.confirm('Tem certeza que deseja deletar esta mensagem?')) {
      try {
        await axios.delete(`/api/automated/${id}`);
        fetchMessages();
      } catch (error) {
        console.error('Error deleting message:', error);
        alert('Erro ao deletar mensagem');
      }
    }
  };

  const handleToggle = async (message) => {
    try {
      await axios.put(`/api/automated/${message.id}`, {
        trigger: message.trigger,
        response: message.response,
        enabled: !message.enabled
      });
      fetchMessages();
    } catch (error) {
      console.error('Error toggling message:', error);
    }
  };

  return (
    <div className="automated-messages-container">
      <h2>Mensagens Automáticas</h2>

      <div className="form-section">
        <h3>{editing ? 'Editar Mensagem' : 'Nova Mensagem Automática'}</h3>
        <form onSubmit={handleSubmit} className="message-form">
          <div className="form-group">
            <p className="info-text">✨ O bot responderá <strong>QUALQUER PESSOA</strong> que mandar mensagem! Use o botão de ativar/desativar para ligar ou desligar cada resposta.</p>
          </div>

          <div className="form-group">
            <label>Palavra-chave para disparar:</label>
            <input
              type="text"
              name="trigger"
              value={formData.trigger}
              onChange={handleInputChange}
              placeholder="Ex: olá, oi, help OU use * para QUALQUER mensagem"
            />
            <small className="hint-text">💡 Dica: Use <strong>*</strong> para responder a QUALQUER mensagem recebida!</small>
          </div>

          <div className="form-group">
            <label>Resposta automática:</label>
            <textarea
              name="response"
              value={formData.response}
              onChange={handleInputChange}
              placeholder="Digite a mensagem que será enviada automaticamente"
              rows="5"
            />
          </div>

          <button type="submit" className="btn-submit">
            {editing ? 'Atualizar Mensagem' : 'Adicionar Mensagem'}
          </button>

          {editing && (
            <button
              type="button"
              className="btn-cancel"
              onClick={() => {
                setEditing(null);
                setFormData({ trigger: '', response: '' });
              }}
            >
              Cancelar
            </button>
          )}
        </form>
      </div>

      <div className="messages-section">
        <h3>Mensagens Configuradas</h3>
        {loading ? (
          <p className="loading-text">Carregando...</p>
        ) : messages.length === 0 ? (
          <p className="no-messages">Nenhuma mensagem automática configurada</p>
        ) : (
          <div className="messages-list">
            {messages.map(message => (
              <div key={message.id} className={`message-card ${!message.enabled ? 'disabled' : ''}`}>
                <div className="message-header">
                  <span className="chat-id">🌍 Global (todas as mensagens)</span>
                  <div className="message-actions">
                    <button
                      className={`btn-toggle ${message.enabled ? 'enabled' : 'disabled'}`}
                      onClick={() => handleToggle(message)}
                      title={message.enabled ? 'Desabilitar' : 'Habilitar'}
                    >
                      {message.enabled ? '✓' : '○'}
                    </button>
                  </div>
                </div>
                
                <div className="message-content">
                  <p><strong>Palavra-chave:</strong> 
                    <span className={`trigger ${message.trigger === '*' ? 'global' : ''}`}>
                      {message.trigger === '*' ? '✓ QUALQUER MENSAGEM' : message.trigger}
                    </span>
                  </p>
                  <p><strong>Resposta:</strong></p>
                  <div className="response-text">{message.response}</div>
                </div>

                <div className="message-footer">
                  <small>Criado em: {new Date(message.created_at).toLocaleDateString('pt-BR')}</small>
                  <div className="message-buttons">
                    <button
                      className="btn-edit"
                      onClick={() => handleEdit(message)}
                    >
                      Editar
                    </button>
                    <button
                      className="btn-delete"
                      onClick={() => handleDelete(message.id)}
                    >
                      Deletar
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

export default AutomatedMessages;
