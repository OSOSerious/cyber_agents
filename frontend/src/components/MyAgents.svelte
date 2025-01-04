<script>
  import { onMount } from 'svelte';
  import { Link } from "svelte-routing";

  let agents = [];
  let isLoading = true;
  let error = null;
  let actionInProgress = null;
  let searchQuery = "";
  let selectedStatus = "all";
  let selectedPlatform = "all";
  let showStopConfirmation = false;
  let selectedAgentToStop = null;
  let sortBy = "name";
  let sortOrder = "asc";
  let currentPage = 1;
  let itemsPerPage = 6;

  let stats = {
    online: 0,
    activeChats: 0,
    totalInteractions: 0
  };

  $: filteredAgents = agents
    .filter(agent => {
      const matchesSearch = agent.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                          agent.description.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesStatus = selectedStatus === "all" || agent.status === selectedStatus;
      const matchesPlatform = selectedPlatform === "all" || agent.platforms.includes(selectedPlatform);
      return matchesSearch && matchesStatus && matchesPlatform;
    })
    .sort((a, b) => {
      const factor = sortOrder === "asc" ? 1 : -1;
      if (sortBy === "name") return factor * a.name.localeCompare(b.name);
      if (sortBy === "status") return factor * a.status.localeCompare(b.status);
      if (sortBy === "messages") return factor * (a.messages - b.messages);
      return 0;
    });

  $: paginatedAgents = filteredAgents.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  $: totalPages = Math.ceil(filteredAgents.length / itemsPerPage);

  function updateStats() {
    stats = {
      online: agents.filter(a => a.status === "active").length,
      activeChats: agents.reduce((sum, a) => sum + (a.activeChats || 0), 0),
      totalInteractions: agents.reduce((sum, a) => sum + a.messages, 0)
    };
  }

  async function stopAgent(agent) {
    if (actionInProgress === agent.id) return;
    
    try {
      actionInProgress = agent.id;
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      agent.status = "stopped";
      agents = agents;
      updateStats();
      showStopConfirmation = false;
      selectedAgentToStop = null;
    } catch (err) {
      error = `Failed to stop agent: ${err.message}`;
    } finally {
      actionInProgress = null;
    }
  }

  function confirmStopAgent(agent) {
    selectedAgentToStop = agent;
    showStopConfirmation = true;
  }

  function changePage(newPage) {
    if (newPage >= 1 && newPage <= totalPages) {
      currentPage = newPage;
    }
  }

  function updateSort(field) {
    if (sortBy === field) {
      sortOrder = sortOrder === "asc" ? "desc" : "asc";
    } else {
      sortBy = field;
      sortOrder = "asc";
    }
  }

  async function updateSkill(agent, skillName, increase = true) {
    if (actionInProgress === agent.id) return;
    
    try {
      actionInProgress = agent.id;
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 500));
      
      const change = increase ? 1 : -1;
      agent.skills[skillName] = Math.min(Math.max(agent.skills[skillName] + change, 0), 100);
      
      // Update agent in the list
      agents = agents;
    } catch (err) {
      console.error('Failed to update skill:', err);
    } finally {
      actionInProgress = null;
    }
  }

  async function loadAgentData() {
    currentPage = 1;
    try {
      const agentFiles = [
        'tech-analyst-agent.json',
        'creative-writer-agent.json',
        'business-strategist-agent.json'
      ];

      const loadedAgents = await Promise.all(
        agentFiles.map(async (file) => {
          console.log(`Fetching ${file}...`);
          const response = await fetch(`/${file}`);
          if (!response.ok) {
            console.error(`Failed to load ${file}:`, response.status, response.statusText);
            throw new Error(`Failed to load ${file}`);
          }
          const data = await response.json();
          console.log(`Loaded data for ${file}:`, data);
          
          // Generate consistent agent ID from name
          const getAgentId = (name) => name.toLowerCase().replace(/[^a-z0-9]/g, '');
          
          return {
            id: getAgentId(data.name),
            name: data.name,
            description: data.description,
            status: data.status,
            skills: data.skills,
            messages: data.messages,
            lastActive: data.lastActive,
            activities: data.activities,
            platforms: data.platforms || [],
            activeChats: data.activeChats || 0,
            avatar: data.avatar || `/icons/default-agent.svg`
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

<div class="agents-container">
  <div class="controls">
    <div class="search-filters">
      <input
        type="text"
        bind:value={searchQuery}
        placeholder="Search agents..."
        class="search-input"
      />
      
      <select bind:value={selectedStatus} class="filter-select">
        <option value="all">All Status</option>
        <option value="active">Active</option>
        <option value="stopped">Stopped</option>
      </select>
      
      <select bind:value={selectedPlatform} class="filter-select">
        <option value="all">All Platforms</option>
        <option value="discord">Discord</option>
        <option value="telegram">Telegram</option>
      </select>
    </div>

    <div class="sort-controls">
      <button 
        class="sort-btn" 
        class:active={sortBy === "name"}
        on:click={() => updateSort("name")}
      >
        Name {sortBy === "name" ? (sortOrder === "asc" ? "↑" : "↓") : ""}
      </button>
      <button 
        class="sort-btn" 
        class:active={sortBy === "status"}
        on:click={() => updateSort("status")}
      >
        Status {sortBy === "status" ? (sortOrder === "asc" ? "↑" : "↓") : ""}
      </button>
      <button 
        class="sort-btn" 
        class:active={sortBy === "messages"}
        on:click={() => updateSort("messages")}
      >
        Messages {sortBy === "messages" ? (sortOrder === "asc" ? "↑" : "↓") : ""}
      </button>
    </div>
  </div>

  <div class="stats-bar">
    <div class="stat">
      <span class="stat-title">Online Agents</span>
      <span class="stat-number">{stats.online}</span>
    </div>
    <div class="stat">
      <span class="stat-title">Active Chats</span>
      <span class="stat-number">{stats.activeChats}</span>
    </div>
    <div class="stat">
      <span class="stat-title">Total Interactions</span>
      <span class="stat-number">{stats.totalInteractions}</span>
    </div>
  </div>

  {#if isLoading}
    <div class="loading-container">
      <div class="loading-spinner"></div>
      <p>Loading agents...</p>
    </div>
  {:else if error}
    <div class="error-container">
      <svg xmlns="http://www.w3.org/2000/svg" class="error-icon" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
      </svg>
      <div class="error-content">
        <h3>Error Loading Agents</h3>
        <p>{error}</p>
      </div>
    </div>
  {:else}
    <div class="agents-grid">
      {#each paginatedAgents as agent}
        <div class="agent-card">
          <div class="agent-header">
            <div class="agent-title">
              <h2>{agent.name}</h2>
              <div class="agent-info">
                <img src={agent.avatar} alt={agent.name} class="agent-avatar" />
                <div class="agent-platforms">
                  {#each agent.platforms as platform}
                    <img 
                      src={`/icons/${platform}.svg`} 
                      alt={platform}
                      class="platform-icon"
                      title={`Connected to ${platform}`}
                    />
                  {/each}
                </div>
              </div>
              <span class="status-badge" class:stopped={agent.status === "stopped"}>
                • {agent.status === "active" ? "Active" : "Stopped"}
              </span>
            </div>
            <p class="agent-description">{agent.description}</p>
          </div>

          <div class="agent-stats">
            <div class="stat-row">
              <div class="stat-item">
                <span class="stat-label">Messages</span>
                <span class="stat-value">{agent.messages}</span>
              </div>
              <div class="stat-item">
                <span class="stat-label">Last Active</span>
                <span class="stat-value">{agent.lastActive}</span>
              </div>
            </div>
          </div>

          <div class="skill-bars">
            {#each Object.entries(agent.skills) as [skill, value]}
              <div class="skill-item">
                <div class="skill-header">
                  <span class="skill-name">{skill}</span>
                  <span class="skill-value">{value}/10</span>
                </div>
                <div class="skill-bar-bg">
                  <div 
                    class="skill-bar-fill"
                    class:wisdom={skill === 'wisdom'}
                    class:patience={skill === 'patience'}
                    class:strength={skill === 'strength'}
                    class:health={skill === 'health'}
                    style="width: {(value/10) * 100}%"
                  ></div>
                </div>
              </div>
            {/each}
          </div>

          <div class="agent-activities">
            {#each agent.activities as activity}
              <div class="activity-item">• {activity}</div>
            {/each}
          </div>

          <div class="agent-actions">
            {#if agent.status === "active"}
              <button 
                class="stop-btn" 
                on:click={() => confirmStopAgent(agent)}
                disabled={actionInProgress === agent.id}
              >
                {actionInProgress === agent.id ? "Stopping..." : "Stop"}
              </button>
            {:else}
              <button class="stopped-btn" disabled>Stopped</button>
            {/if}
            <Link to={`/agents/${agent.id}`} class="view-btn">View</Link>
          </div>
        </div>
      {/each}
    </div>

    {#if totalPages > 1}
      <div class="pagination">
        <button 
          class="page-btn" 
          disabled={currentPage === 1}
          on:click={() => changePage(currentPage - 1)}
        >
          Previous
        </button>
        
        {#each Array(totalPages) as _, i}
          <button 
            class="page-btn" 
            class:active={currentPage === i + 1}
            on:click={() => changePage(i + 1)}
          >
            {i + 1}
          </button>
        {/each}
        
        <button 
          class="page-btn" 
          disabled={currentPage === totalPages}
          on:click={() => changePage(currentPage + 1)}
        >
          Next
        </button>
      </div>
    {/if}
  {/if}
</div>

{#if showStopConfirmation}
  <div class="modal-overlay">
    <div class="modal">
      <h3>Stop Agent</h3>
      <p>Are you sure you want to stop {selectedAgentToStop?.name}?</p>
      <div class="modal-actions">
        <button 
          class="cancel-btn"
          on:click={() => {
            showStopConfirmation = false;
            selectedAgentToStop = null;
          }}
        >
          Cancel
        </button>
        <button 
          class="confirm-btn"
          on:click={() => stopAgent(selectedAgentToStop)}
        >
          Confirm Stop
        </button>
      </div>
    </div>
  </div>
{/if}

<style>
  .controls {
    margin-bottom: 2rem;
    display: flex;
    justify-content: space-between;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .search-filters {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .search-input {
    padding: 0.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    min-width: 250px;
  }

  .filter-select {
    padding: 0.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    background: white;
  }

  .sort-controls {
    display: flex;
    gap: 0.5rem;
  }

  .sort-btn {
    padding: 0.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    background: white;
    cursor: pointer;
    transition: all 0.2s;
  }

  .sort-btn.active {
    background: #7c3aed;
    color: white;
    border-color: #7c3aed;
  }

  .stats-bar {
    display: flex;
    justify-content: space-around;
    background: white;
    padding: 1.5rem;
    border-radius: 1rem;
    margin-bottom: 2rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .stat {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
  }

  .stat-title {
    font-size: 0.875rem;
    color: #6b7280;
  }

  .stat-number {
    font-size: 1.5rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .agents-container {
    padding: 2rem;
    background-color: #f3f4f6;
  }

  .agents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 2rem;
  }

  .agent-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .agent-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  }

  .agent-header {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
  }

  .agent-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .agent-title h2 {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .agent-info {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .agent-avatar {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 50%;
    object-fit: cover;
  }

  .agent-platforms {
    display: flex;
    gap: 0.5rem;
  }

  .platform-icon {
    width: 1.25rem;
    height: 1.25rem;
  }

  .status-badge {
    font-size: 0.75rem;
    color: #10b981;
    background: #d1fae5;
    padding: 0.25rem 0.75rem;
    border-radius: 9999px;
    font-weight: 500;
  }

  .status-badge.stopped {
    color: #dc2626;
    background: #fee2e2;
  }

  .agent-description {
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
  }

  .agent-stats {
    background: #f8fafc;
    border-radius: 0.75rem;
    padding: 1rem;
  }

  .stat-row {
    display: flex;
    justify-content: space-between;
  }

  .stat-item {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .stat-label {
    font-size: 0.75rem;
    color: #6b7280;
  }

  .stat-value {
    font-size: 0.875rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .skill-bars {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .skill-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .skill-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .skill-name {
    font-size: 0.875rem;
    color: #4b5563;
    text-transform: capitalize;
  }

  .skill-value {
    font-size: 0.75rem;
    color: #6b7280;
  }

  .skill-bar-bg {
    height: 0.5rem;
    background: #f3f4f6;
    border-radius: 9999px;
    overflow: hidden;
  }

  .skill-bar-fill {
    height: 100%;
    border-radius: 9999px;
    transition: width 0.5s ease;
  }

  .skill-bar-fill.wisdom { background: #3b82f6; }
  .skill-bar-fill.patience { background: #06b6d4; }
  .skill-bar-fill.strength { background: #ef4444; }
  .skill-bar-fill.health { background: #10b981; }

  .agent-activities {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .activity-item {
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
  }

  .agent-actions {
    display: flex;
    gap: 1rem;
    margin-top: auto;
  }

  .stop-btn, .view-btn {
    flex: 1;
    padding: 0.625rem;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    text-align: center;
    transition: all 0.2s;
  }

  .stop-btn {
    background: #fee2e2;
    color: #dc2626;
    border: none;
    cursor: pointer;
  }

  .stop-btn:hover {
    background: #fecaca;
  }

  .stopped-btn {
    flex: 1;
    padding: 0.625rem;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    text-align: center;
    background: #e5e7eb;
    color: #9ca3af;
    border: none;
    cursor: not-allowed;
  }

  .pagination {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-top: 2rem;
  }

  .page-btn {
    padding: 0.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    background: white;
    cursor: pointer;
    transition: all 0.2s;
  }

  .page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .page-btn.active {
    background: #7c3aed;
    color: white;
    border-color: #7c3aed;
  }

  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .modal {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    width: 90%;
    max-width: 400px;
  }

  .modal h3 {
    margin: 0 0 1rem 0;
    font-size: 1.25rem;
    font-weight: 600;
  }

  .modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
    margin-top: 2rem;
  }

  .cancel-btn, .confirm-btn {
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    cursor: pointer;
  }

  .cancel-btn {
    background: #e5e7eb;
    border: none;
    color: #4b5563;
  }

  .confirm-btn {
    background: #dc2626;
    border: none;
    color: white;
  }

  .view-btn {
    color: #7c3aed;
    text-decoration: none;
    border: 1px solid #7c3aed;
  }

  .view-btn:hover {
    background: #7c3aed;
    color: white;
  }

  .loading-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 300px;
    gap: 1rem;
  }

  .loading-spinner {
    width: 3rem;
    height: 3rem;
    border: 3px solid #e5e7eb;
    border-top-color: #4f46e5;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  .loading-container p {
    color: #6b7280;
    font-size: 0.875rem;
  }

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  .error-container {
    display: flex;
    align-items: center;
    gap: 1rem;
    background: #fee2e2;
    border-radius: 0.75rem;
    padding: 1.5rem;
    margin: 1rem 0;
  }

  .error-icon {
    width: 2rem;
    height: 2rem;
    color: #dc2626;
    flex-shrink: 0;
  }

  .error-content h3 {
    color: #dc2626;
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 0.25rem;
  }

  .error-content p {
    color: #991b1b;
    font-size: 0.875rem;
  }

  @media (max-width: 768px) {
    .agents-container {
      padding: 1rem;
    }

    .agents-grid {
      grid-template-columns: 1fr;
    }
  }
</style>
