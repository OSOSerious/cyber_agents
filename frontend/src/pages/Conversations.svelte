<script>
  import { onMount } from 'svelte';
  import { api } from '../services/api';
  import DashboardLayout from '../components/DashboardLayout.svelte';

  let interactions = [];
  let loading = true;
  let error = null;
  let page = 1;
  let perPage = 10;
  let selectedInteraction = null;
  let aiSuggestion = null;

  async function loadInteractions() {
    try {
      const data = await api.getInteractions(page, perPage);
      interactions = data;
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  async function getAISuggestion(interaction) {
    try {
      const suggestion = await api.getAISuggestion(interaction.id);
      aiSuggestion = suggestion;
    } catch (e) {
      console.error('Error getting AI suggestion:', e);
    }
  }

  async function assignToAgent(interaction) {
    try {
      await api.assignToAgent(interaction.id);
      await loadInteractions();
    } catch (e) {
      error = e.message;
    }
  }

  function handleInteractionSelect(interaction) {
    selectedInteraction = interaction;
    getAISuggestion(interaction);
  }

  onMount(loadInteractions);
</script>

<DashboardLayout>
  <div class="conversations">
    <header>
      <h1>Active Interactions</h1>
      <div class="header-actions">
        <button class="filter-btn active">All Channels</button>
        <button class="filter-btn">Web Chat</button>
        <button class="filter-btn">Voice</button>
        <button class="filter-btn">Video</button>
      </div>
    </header>

    {#if loading}
      <div class="loading">Loading interactions...</div>
    {:else if error}
      <div class="error">{error}</div>
    {:else}
      <div class="interactions-container">
        <!-- Interactions List -->
        <div class="interactions-list">
          {#each interactions as interaction}
            <div 
              class="interaction-card"
              class:selected={selectedInteraction?.id === interaction.id}
              on:click={() => handleInteractionSelect(interaction)}
            >
              <div class="interaction-header">
                <div class="channel-badge {interaction.channel}">
                  {#if interaction.channel === 'web_chat'}
                    💬
                  {:else if interaction.channel === 'voice'}
                    📞
                  {:else if interaction.channel === 'video'}
                    🤳
                  {:else if interaction.channel === 'messaging'}
                    📱
                  {/if}
                  {interaction.channel.replace('_', ' ')}
                </div>
                <span class="timestamp">{new Date(interaction.inserted_at).toLocaleString()}</span>
              </div>
              
              <div class="interaction-content">
                <p class="message">{interaction.message}</p>
                <div class="ai-tags">
                  {#if interaction.intent}
                    <span class="tag intent">Intent: {interaction.intent}</span>
                  {/if}
                  {#if interaction.sentiment}
                    <span class="tag sentiment">Sentiment: {interaction.sentiment}</span>
                  {/if}
                </div>
              </div>

              <div class="interaction-footer">
                <span class="status {interaction.status}">{interaction.status}</span>
                {#if interaction.ai_confidence}
                  <span class="ai-confidence">
                    AI Confidence: {interaction.ai_confidence}%
                  </span>
                {/if}
              </div>
            </div>
          {/each}
        </div>

        <!-- Interaction Details -->
        <div class="interaction-details">
          {#if selectedInteraction}
            <div class="details-content">
              <div class="details-header">
                <h2>Interaction Details</h2>
                <div class="action-buttons">
                  <button class="action-btn voice">
                    📞 Voice Call
                  </button>
                  <button class="action-btn video">
                    🤳 Video Chat
                  </button>
                </div>
              </div>

              <div class="details-section">
                <h3>AI Analysis</h3>
                {#if aiSuggestion}
                  <div class="ai-suggestion">
                    <div class="suggestion-header">
                      <span class="label">Recommended Action:</span>
                      <span class="value">{aiSuggestion.recommendation}</span>
                    </div>
                    <div class="suggestion-details">
                      <div class="detail-item">
                        <span class="label">Priority:</span>
                        <span class="value priority-{aiSuggestion.priority}">{aiSuggestion.priority}</span>
                      </div>
                      <div class="detail-item">
                        <span class="label">Required Expertise:</span>
                        <span class="value">{aiSuggestion.required_expertise}</span>
                      </div>
                      <div class="detail-item">
                        <span class="label">Suggested Channel:</span>
                        <span class="value">{aiSuggestion.suggested_channel}</span>
                      </div>
                    </div>
                  </div>
                {/if}
              </div>

              <div class="details-section">
                <h3>Action Required</h3>
                <div class="action-options">
                  <button class="option-btn ai" on:click={() => assignToAgent(selectedInteraction, 'ai')}>
                    🤖 Let AI Handle
                  </button>
                  <button class="option-btn human" on:click={() => assignToAgent(selectedInteraction, 'human')}>
                    👤 Assign to Human Agent
                  </button>
                </div>
              </div>
            </div>
          {:else}
            <div class="no-selection">
              <div class="placeholder-content">
                <span class="placeholder-icon">👋</span>
                <h3>Select an Interaction</h3>
                <p>Choose an interaction from the list to view details and take action</p>
              </div>
            </div>
          {/if}
        </div>
      </div>
    {/if}
  </div>
</DashboardLayout>

<style>
  .conversations {
    padding: 2em;
    height: 100%;
  }

  header {
    margin-bottom: 2em;
  }

  h1 {
    margin: 0 0 1em;
    color: #2d3748;
  }

  .header-actions {
    display: flex;
    gap: 1em;
  }

  .filter-btn {
    background: none;
    border: 2px solid #e2e8f0;
    padding: 0.5em 1em;
    border-radius: 20px;
    color: #4a5568;
    cursor: pointer;
    transition: all 0.2s;
  }

  .filter-btn:hover {
    background: #f7fafc;
  }

  .filter-btn.active {
    background: #4f46e5;
    border-color: #4f46e5;
    color: white;
  }

  .interactions-container {
    display: grid;
    grid-template-columns: 400px 1fr;
    gap: 2em;
    height: calc(100vh - 200px);
  }

  .interactions-list {
    overflow-y: auto;
    padding-right: 1em;
  }

  .interaction-card {
    background: white;
    border-radius: 15px;
    padding: 1.5em;
    margin-bottom: 1em;
    cursor: pointer;
    transition: all 0.2s;
    border: 2px solid transparent;
  }

  .interaction-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .interaction-card.selected {
    border-color: #4f46e5;
  }

  .interaction-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1em;
  }

  .channel-badge {
    display: flex;
    align-items: center;
    gap: 0.5em;
    padding: 0.5em 1em;
    border-radius: 20px;
    font-size: 0.9em;
    background: #f7fafc;
    color: #4a5568;
    text-transform: capitalize;
  }

  .timestamp {
    color: #718096;
    font-size: 0.9em;
  }

  .interaction-content {
    margin-bottom: 1em;
  }

  .message {
    color: #2d3748;
    margin: 0 0 1em;
    line-height: 1.5;
  }

  .ai-tags {
    display: flex;
    gap: 0.5em;
    flex-wrap: wrap;
  }

  .tag {
    padding: 0.3em 0.8em;
    border-radius: 15px;
    font-size: 0.8em;
  }

  .tag.intent {
    background: #ebf4ff;
    color: #3182ce;
  }

  .tag.sentiment {
    background: #faf5ff;
    color: #805ad5;
  }

  .interaction-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .status {
    padding: 0.3em 0.8em;
    border-radius: 15px;
    font-size: 0.8em;
    text-transform: capitalize;
  }

  .status.pending {
    background: #fef3c7;
    color: #d97706;
  }

  .status.active {
    background: #dcfce7;
    color: #059669;
  }

  .status.completed {
    background: #e0e7ff;
    color: #4f46e5;
  }

  .ai-confidence {
    color: #718096;
    font-size: 0.9em;
  }

  .interaction-details {
    background: white;
    border-radius: 15px;
    padding: 2em;
    overflow-y: auto;
  }

  .details-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2em;
  }

  .action-buttons {
    display: flex;
    gap: 1em;
  }

  .action-btn {
    padding: 0.8em 1.5em;
    border-radius: 25px;
    border: none;
    color: white;
    cursor: pointer;
    transition: transform 0.2s;
    font-weight: 500;
  }

  .action-btn.voice {
    background: linear-gradient(135deg, #3182ce 0%, #2c5282 100%);
  }

  .action-btn.video {
    background: linear-gradient(135deg, #805ad5 0%, #553c9a 100%);
  }

  .action-btn:hover {
    transform: translateY(-2px);
  }

  .details-section {
    background: #f7fafc;
    border-radius: 15px;
    padding: 1.5em;
    margin-bottom: 1.5em;
  }

  .details-section h3 {
    margin: 0 0 1em;
    color: #2d3748;
  }

  .ai-suggestion {
    background: white;
    border-radius: 10px;
    padding: 1.5em;
  }

  .suggestion-header {
    margin-bottom: 1em;
    padding-bottom: 1em;
    border-bottom: 1px solid #e2e8f0;
  }

  .suggestion-details {
    display: grid;
    gap: 1em;
  }

  .detail-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .label {
    color: #718096;
  }

  .value {
    font-weight: 500;
    color: #2d3748;
  }

  .value.priority-high {
    color: #e53e3e;
  }

  .value.priority-medium {
    color: #d97706;
  }

  .value.priority-low {
    color: #059669;
  }

  .action-options {
    display: grid;
    gap: 1em;
  }

  .option-btn {
    padding: 1em;
    border-radius: 10px;
    border: none;
    color: white;
    cursor: pointer;
    transition: transform 0.2s;
    font-weight: 500;
    text-align: center;
  }

  .option-btn.ai {
    background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
  }

  .option-btn.human {
    background: linear-gradient(135deg, #059669 0%, #047857 100%);
  }

  .option-btn:hover {
    transform: translateY(-2px);
  }

  .no-selection {
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #718096;
    text-align: center;
  }

  .placeholder-icon {
    font-size: 3em;
    margin-bottom: 0.5em;
    display: block;
  }

  @media (max-width: 1024px) {
    .interactions-container {
      grid-template-columns: 1fr;
    }

    .interaction-details {
      display: none;
    }
  }

  @media (max-width: 768px) {
    .conversations {
      padding: 1em;
    }

    .header-actions {
      overflow-x: auto;
      padding-bottom: 1em;
    }

    .interaction-card {
      padding: 1em;
    }
  }
</style>
