import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './TelegramBots.css';

function TelegramBots() {
  const [bots, setBots] = useState([]);
  const [loading, setLoading] = useState(true);
  const [formData, setFormData] = useState({
    botToken: '',
    botUsername: ''
  });
  const [editing, setEditing] = useState(null);

  useEffect(() => {
    fetchBots();
  }, []);

  const fetchBots = async () => {
    try {
      const response = await axios.get('/api/telegram');
      setBots(response.data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching Telegram bots:', error);
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

    if (!formData.botToken) {
      alert('Por favor, insira o token do bot do Telegram');
      return;
    }

    try {
      if (editing) {
        await axios.put(`/api/telegram/${editing.id}`, {
          botToken: formData.botToken,
          botUsername: formData.botUsername,
          enabled: editing.enabled
        });
      } else {
        await axios.post('/api/telegram', formData);
      }

      setFormData({ botToken: '', botUsername: '' });
      setEditing(null);
      fetchBots();
    } catch (error) {
      console.error('Error saving Telegram bot:', error);
      alert('Erro ao salvar bot do Telegram');
    }
  };

  const handleEdit = (bot) => {
    setEditing(bot);
    setFormData({
      botToken: bot.bot_token,
      botUsername: bot.bot_username || ''
    });
  };

  const handleDelete = async (id) => {
    if (window.confirm('Tem certeza que deseja deletar este bot do Telegram?')) {
      try {
        await axios.delete(`/api/telegram/${id}`);
        fetchBots();
      } catch (error) {
        console.error('Error deleting Telegram bot:', error);
        alert('Erro ao deletar bot do Telegram');
      }
    }
  };

  const handleToggle = async (bot) => {
    try {
      await axios.put(`/api/telegram/${bot.id}`, {
        botToken: bot.bot_token,
        botUsername: bot.bot_username,
        enabled: !bot.enabled
      });
      fetchBots();
    } catch (error) {
      console.error('Error toggling Telegram bot:', error);
    }
  };

  return (
    <div className="telegram-bots-container">
      <h2>🤖 Bots do Telegram</h2>

      <div className="info-section">
        <div className="info-card">
          <h3>📋 Como criar um bot do Telegram:</h3>
          <ol>
            <li>Abra o Telegram e procure por <strong>@BotFather</strong></li>
            <li>Envie <code>/newbot</code> e siga as instruções</li>
            <li>Copie o <strong>token</strong> fornecido</li>
            <li>Cole o token aqui e configure suas respostas automáticas</li>
          </ol>
        </div>
      </div>

      <div className="form-section">
        <h3>{editing ? 'Editar Bot do Telegram' : 'Novo Bot do Telegram'}</h3>
        <form onSubmit={handleSubmit} className="bot-form">
          <div className="form-group">
            <label>Token do Bot*:</label>
            <input
              type="text"
              name="botToken"
              value={formData.botToken}
              onChange={handleInputChange}
              placeholder="Ex: 1234567890:ABCdefGHIjklMNOpqrsTUVwxyz"
            />
            <small className="hint-text">💡 Obtenha o token com @BotFather no Telegram</small>
          </div>

          <div className="form-group">
            <label>Nome de Usuário (opcional):</label>
            <input
              type="text"
              name="botUsername"
              value={formData.botUsername}
              onChange={handleInputChange}
              placeholder="Ex: meu_bot"
            />
          </div>

          <button type="submit" className="btn-submit">
            {editing ? 'Atualizar Bot' : 'Adicionar Bot'}
          </button>

          {editing && (
            <button
              type="button"
              className="btn-cancel"
              onClick={() => {
                setEditing(null);
                setFormData({ botToken: '', botUsername: '' });
              }}
            >
              Cancelar
            </button>
          )}
        </form>
      </div>

      <div className="bots-section">
        <h3>Bots Configurados</h3>
        {loading ? (
          <p className="loading-text">Carregando...</p>
        ) : bots.length === 0 ? (
          <p className="no-bots">Nenhum bot do Telegram configurado</p>
        ) : (
          <div className="bots-list">
            {bots.map(bot => (
              <div key={bot.id} className={`bot-card ${!bot.enabled ? 'disabled' : ''}`}>
                <div className="bot-header">
                  <span className="bot-username">@{bot.bot_username || 'Bot'}</span>
                  <div className="bot-actions">
                    <button
                      className={`btn-toggle ${bot.enabled ? 'enabled' : 'disabled'}`}
                      onClick={() => handleToggle(bot)}
                      title={bot.enabled ? 'Desabilitar' : 'Habilitar'}
                    >
                      {bot.enabled ? '✓' : '○'}
                    </button>
                  </div>
                </div>

                <div className="bot-content">
                  <p><strong>Token:</strong> {bot.bot_token.substring(0, 20)}...</p>
                  <p><strong>Status:</strong>
                    <span className={`status ${bot.enabled ? 'active' : 'inactive'}`}>
                      {bot.enabled ? 'Ativo' : 'Inativo'}
                    </span>
                  </p>
                </div>

                <div className="bot-footer">
                  <small>Criado em: {new Date(bot.created_at).toLocaleDateString('pt-BR')}</small>
                  <div className="bot-buttons">
                    <button
                      className="btn-edit"
                      onClick={() => handleEdit(bot)}
                    >
                      Editar
                    </button>
                    <button
                      className="btn-delete"
                      onClick={() => handleDelete(bot.id)}
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

export default TelegramBots;