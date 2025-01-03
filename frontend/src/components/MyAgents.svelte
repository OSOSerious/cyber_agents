<script>
  import { onMount } from 'svelte';
  import { Link } from "svelte-routing";

  let agents = [];
  let isLoading = true;
  let error = null;
  let actionInProgress = null;

  async function toggleAgentStatus(agent) {
    if (actionInProgress === agent.id) return;
    
    try {
      actionInProgress = agent.id;
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 500));
      agent.status = agent.status === 'active' ? 'inactive' : 'active';
    } catch (err) {
      console.error('Failed to toggle agent status:', err);
    } finally {
      actionInProgress = null;
    }
  }

  async function loadAgentData() {
    try {
      const agentFiles = [
        'tech-analyst-agent.json',
        'creative-writer-agent.json',
        'business-strategist-agent.json'
      ];

      const loadedAgents = await Promise.all(
        agentFiles.map(async (file) => {
          const response = await fetch(`/${file}`);
          if (!response.ok) throw new Error(`Failed to load ${file}`);
          const data = await response.json();
          
          return {
            id: data.name.toLowerCase().replace(/\s+/g, '-'),
            name: data.name,
            description: data.description || 'AI Assistant',
            status: data.deployment?.autoStart ? 'active' : 'inactive',
            messages: data.metrics?.interactions || 0,
            lastActive: new Date().toISOString()
          };
        })
      );

      agents = loadedAgents;
      error = null;
    } catch (err) {
      console.error('Failed to load agent data:', err);
      error = 'Failed to load agent data. Please try again later.';
    } finally {
      isLoading = false;
    }
  }

  onMount(loadAgentData);

  function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleString();
  }
</script>

<div class="agents-page">
  <header>
    <h1>Active Agents</h1>
    <Link to="/character-builder" class="new-agent-btn">
      <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
      </svg>
      New Agent
    </Link>
  </header>

  {#if isLoading}
    <div class="loading">Loading agents...</div>
  {:else if error}
    <div class="error">{error}</div>
  {:else}
    <div class="agents-grid">
      {#each agents as agent}
        <div class="agent-card">
          <div class="agent-header">
            <h2>{agent.name}</h2>
            <div class="status-badge {agent.status}">
              <span class="status-dot"></span>
              {agent.status === 'active' ? 'Active' : 'Inactive'}
            </div>
          </div>
          <p class="agent-description">{agent.description}</p>
          <div class="agent-stats">
            <div class="stat">
              <span class="stat-value">{agent.messages}</span>
              <span class="stat-label">Messages</span>
            </div>
            <div class="stat">
              <span class="stat-value">{formatDate(agent.lastActive)}</span>
              <span class="stat-label">Last Active</span>
            </div>
          </div>
          <div class="agent-actions">
            <button 
              class="action-btn {agent.status === 'active' ? 'stop' : 'start'} {actionInProgress === agent.id ? 'loading' : ''}"
              on:click={() => toggleAgentStatus(agent)}
              disabled={actionInProgress === agent.id}
            >
              {agent.status === 'active' ? 'Stop' : 'Start'}
            </button>
            <Link to={`/agents/${agent.id}`} class="action-btn view">View</Link>
          </div>
        </div>
      {/each}
    </div>

  {/if}
</div>

<style>
  .agents-page {
    padding: 2rem;
  }

  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
  }

  h1 {
    font-size: 1.5rem;
    font-weight: 600;
    color: #1f2937;
  }

  .agents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .agent-card {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    padding: 1rem;
  }

  .agent-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .agent-header h2 {
    font-size: 1.125rem;
    font-weight: 500;
    color: #1f2937;
  }

  .agent-description {
    color: #6b7280;
    font-size: 0.875rem;
    margin-bottom: 1rem;
  }

  .agent-stats {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1rem;
    padding: 0.5rem;
    background: #f9fafb;
    border-radius: 6px;
  }

  .stat {
    text-align: center;
  }

  .stat-value {
    display: block;
    font-weight: 500;
    color: #1f2937;
  }

  .stat-label {
    font-size: 0.75rem;
    color: #6b7280;
  }

  .agent-actions {
    display: flex;
    gap: 0.5rem;
  }

  .action-btn {
    flex: 1;
    padding: 0.5rem;
    border: none;
    border-radius: 4px;
    font-size: 0.875rem;
    cursor: pointer;
    transition: all 0.2s;
  }

  .action-btn.start {
    background: #4f46e5;
    color: white;
  }

  .action-btn.stop {
    background: #ef4444;
    color: white;
  }

  .action-btn.view {
    background: #f3f4f6;
    color: #374151;
    text-decoration: none;
    text-align: center;
  }

  .new-agent-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #4f46e5;
    color: white;
    border-radius: 4px;
    font-size: 0.875rem;
    text-decoration: none;
  }

  .new-agent-btn:hover {
    background: #4338ca;
  }

  .icon {
    width: 16px;
    height: 16px;
  }

  .action-btn.loading {
    position: relative;
    color: transparent;
  }

  .action-btn.loading::after {
    content: "";
    position: absolute;
    left: 50%;
    top: 50%;
    width: 16px;
    height: 16px;
    margin: -8px 0 0 -8px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top-color: white;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  .action-btn[disabled] {
    opacity: 0.7;
    cursor: not-allowed;
  }

  .status-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    padding: 0.25rem 0.5rem;
    border-radius: 9999px;
    font-size: 0.75rem;
  }

  .status-badge.active {
    background: #dcfce7;
    color: #166534;
  }

  .status-badge.inactive {
    background: #fee2e2;
    color: #991b1b;
  }

  .status-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
  }

  .status-badge.active .status-dot {
    background: #16a34a;
  }

  .status-badge.inactive .status-dot {
    background: #dc2626;
  }

  .loading {
    text-align: center;
    padding: 2rem;
    color: #6b7280;
  }

  .error {
    text-align: center;
    padding: 2rem;
    color: #dc2626;
  }


  @media (max-width: 768px) {
    .agents-grid {
      grid-template-columns: 1fr;
    }

    .agents-page {
      padding: 1rem;
    }
  }
</style>
