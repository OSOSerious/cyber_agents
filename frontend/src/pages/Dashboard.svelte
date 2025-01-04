<script>
  import DashboardLayout from '../components/DashboardLayout.svelte';
  import MyAgents from '../components/MyAgents.svelte';
  import { Link } from 'svelte-routing';
  import { onMount } from 'svelte';
  import { user } from '../stores/auth';

  let myAgentsComponent;
  let activeConnections = [];
  let documentStats = {
    totalDocuments: 0,
    processedDocuments: 0,
    pendingDocuments: 0
  };
  let recentActivity = [];
  let quickActions = [
    { icon: '🤖', label: 'Create New Agent', link: '/agents/create' },
    { icon: '📊', label: 'View Analytics', link: '/analytics' },
    { icon: '🔗', label: 'Add Platform', link: '/settings' },
    { icon: '📚', label: 'View Tutorials', link: '/tutorials' }
  ];

  onMount(async () => {
    // Simulated data - would be fetched from backend in production
    activeConnections = [
      { platform: 'Discord', status: 'connected', channels: 5, activity: '89%' },
      { platform: 'Twitter', status: 'connected', accounts: 2, activity: '76%' },
      { platform: 'Telegram', status: 'connected', groups: 3, activity: '92%' }
    ];

    documentStats = {
      totalDocuments: 156,
      processedDocuments: 142,
      pendingDocuments: 14
    };

    recentActivity = [
      { type: 'interaction', platform: 'Discord', time: '5m ago', description: 'Agent responded to 15 messages' },
      { type: 'system', platform: 'Telegram', time: '15m ago', description: 'New group chat connected' },
      { type: 'performance', platform: 'Twitter', time: '1h ago', description: 'Response time improved by 15%' }
    ];
  });

  $: timeOfDay = (() => {
    const hour = new Date().getHours();
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  })();
</script>

<DashboardLayout>
  <div class="dashboard-content">
    <header class="welcome-header">
      <div class="welcome-text">
        <h1>Good {timeOfDay}, {$user?.name || 'User'}</h1>
        <p>Here's what's happening with your AI agents today</p>
      </div>
      <div class="quick-actions">
        {#each quickActions as action}
          <Link to={action.link} class="quick-action-button">
            <span class="action-icon">{action.icon}</span>
            <span class="action-label">{action.label}</span>
          </Link>
        {/each}
      </div>
    </header>

    <div class="dashboard-grid">
      <div class="main-content">
        <section class="agents-section">
          <div class="section-header">
            <h2>Your Active Agents</h2>
            <Link to="/agents/create" class="new-agent-button">
              <span>+</span> New Agent
            </Link>
          </div>
          <MyAgents bind:this={myAgentsComponent} />
        </section>

        <section class="activity-section">
          <h2>Recent Activity</h2>
          <div class="activity-list">
            {#each recentActivity as activity}
              <div class="activity-item">
                <div class="activity-icon">
                  {#if activity.type === 'interaction'}🗣️
                  {:else if activity.type === 'system'}⚙️
                  {:else}📈{/if}
                </div>
                <div class="activity-details">
                  <p class="activity-description">{activity.description}</p>
                  <span class="activity-meta">{activity.platform} • {activity.time}</span>
                </div>
              </div>
            {/each}
          </div>
        </section>
      </div>

      <div class="side-panel">
        <section class="connections-section">
          <h2>Platform Connections</h2>
          <div class="connections-list">
            {#each activeConnections as connection}
              <div class="connection-card">
                <div class="connection-header">
                  <h4>{connection.platform}</h4>
                  <span class="status-badge connected">Active</span>
                </div>
                <div class="connection-details">
                  <div class="connection-stats">
                    {#if connection.channels}
                      <span>{connection.channels} channels</span>
                    {/if}
                    {#if connection.accounts}
                      <span>{connection.accounts} accounts</span>
                    {/if}
                    {#if connection.groups}
                      <span>{connection.groups} groups</span>
                    {/if}
                  </div>
                  <div class="activity-bar">
                    <div class="activity-progress" style="width: {connection.activity}"></div>
                    <span class="activity-label">{connection.activity} Active</span>
                  </div>
                </div>
              </div>
            {/each}
          </div>
        </section>

        <section class="documents-section">
          <h2>Document Processing</h2>
          <div class="document-stats">
            <div class="stat-card">
              <span class="stat-label">Total Documents</span>
              <span class="stat-value">{documentStats.totalDocuments}</span>
            </div>
            <div class="stat-card">
              <span class="stat-label">Processed</span>
              <span class="stat-value success">{documentStats.processedDocuments}</span>
            </div>
            <div class="stat-card">
              <span class="stat-label">Pending</span>
              <span class="stat-value warning">{documentStats.pendingDocuments}</span>
            </div>
            <div class="progress-container">
              <div class="progress-bar">
                <div 
                  class="progress" 
                  style="width: {(documentStats.processedDocuments / documentStats.totalDocuments) * 100}%"
                ></div>
              </div>
              <span class="progress-label">
                {Math.round((documentStats.processedDocuments / documentStats.totalDocuments) * 100)}% Complete
              </span>
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</DashboardLayout>

<style>
  .dashboard-content {
    padding: 2rem;
    background: #f8fafc;
    min-height: 100vh;
  }

  .welcome-header {
    margin-bottom: 2rem;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 2rem;
  }

  .welcome-text h1 {
    font-size: 2rem;
    color: #1e293b;
    margin: 0 0 0.5rem;
    font-weight: 700;
  }

  .welcome-text p {
    color: #64748b;
    font-size: 1.1rem;
  }

  .quick-actions {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .quick-action-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #4f46e5;
    color: white;
    border-radius: 0.5rem;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s;
  }

  .quick-action-button:hover {
    background: #4338ca;
  }

  .action-icon {
    font-size: 1.25rem;
  }

  .dashboard-grid {
    display: grid;
    grid-template-columns: 1fr 350px;
    gap: 2rem;
  }

  .main-content {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
  }

  .new-agent-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #4f46e5;
    color: white;
    border-radius: 0.5rem;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s;
  }

  .new-agent-button:hover {
    background: #4338ca;
  }

  .activity-section {
    background: white;
    padding: 1.5rem;
    border-radius: 1rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .activity-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .activity-item {
    display: flex;
    gap: 1rem;
    padding: 1rem;
    background: #f8fafc;
    border-radius: 0.75rem;
  }

  .activity-icon {
    font-size: 1.5rem;
  }

  .activity-details {
    flex: 1;
  }

  .activity-description {
    color: #1e293b;
    margin: 0 0 0.25rem;
  }

  .activity-meta {
    color: #64748b;
    font-size: 0.875rem;
  }

  .side-panel {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .connections-section,
  .documents-section {
    background: white;
    padding: 1.5rem;
    border-radius: 1rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  h2 {
    color: #1e293b;
    font-size: 1.25rem;
    font-weight: 600;
    margin: 0 0 1.5rem;
  }

  .connections-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .connection-card {
    padding: 1rem;
    background: #f8fafc;
    border-radius: 0.75rem;
  }

  .connection-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.75rem;
  }

  .connection-header h4 {
    color: #1e293b;
    font-weight: 600;
    margin: 0;
  }

  .status-badge {
    font-size: 0.75rem;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
  }

  .status-badge.connected {
    background: #dcfce7;
    color: #166534;
  }

  .connection-details {
    color: #64748b;
    font-size: 0.875rem;
  }

  .connection-stats {
    display: flex;
    gap: 1rem;
    margin-bottom: 0.5rem;
  }

  .activity-bar {
    height: 4px;
    background: #e2e8f0;
    border-radius: 2px;
    position: relative;
  }

  .activity-progress {
    height: 100%;
    background: #4f46e5;
    border-radius: 2px;
  }

  .activity-label {
    position: absolute;
    right: 0;
    top: -1.5rem;
    font-size: 0.75rem;
    color: #64748b;
  }

  .document-stats {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .stat-card {
    padding: 1rem;
    background: #f8fafc;
    border-radius: 0.75rem;
    display: flex;
    flex-direction: column;
  }

  .stat-label {
    font-size: 0.875rem;
    color: #64748b;
  }

  .stat-value {
    font-size: 1.5rem;
    font-weight: 600;
    color: #1e293b;
  }

  .stat-value.success {
    color: #059669;
  }

  .stat-value.warning {
    color: #d97706;
  }

  .progress-container {
    margin-top: 0.5rem;
  }

  .progress-bar {
    width: 100%;
    height: 4px;
    background: #e2e8f0;
    border-radius: 2px;
    overflow: hidden;
    margin-bottom: 0.5rem;
  }

  .progress {
    height: 100%;
    background: #4f46e5;
    border-radius: 2px;
    transition: width 0.3s ease;
  }

  .progress-label {
    font-size: 0.75rem;
    color: #64748b;
  }

  @media (max-width: 1024px) {
    .dashboard-grid {
      grid-template-columns: 1fr;
    }

    .welcome-header {
      flex-direction: column;
      align-items: stretch;
    }

    .quick-actions {
      grid-template-columns: repeat(2, 1fr);
    }
  }
</style>
