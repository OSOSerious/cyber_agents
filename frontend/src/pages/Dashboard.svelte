<script>
  import DashboardLayout from '../components/DashboardLayout.svelte';
  import MyAgents from '../components/MyAgents.svelte';
  import { onMount } from 'svelte';

  let myAgentsComponent;
  let activeConnections = [];
  let documentStats = {
    totalDocuments: 0,
    processedDocuments: 0,
    pendingDocuments: 0
  };

  onMount(async () => {
    // Simulated data - would be fetched from backend in production
    activeConnections = [
      { platform: 'Discord', status: 'connected', channels: 5 },
      { platform: 'Twitter', status: 'connected', accounts: 2 },
      { platform: 'Telegram', status: 'connected', groups: 3 }
    ];

    documentStats = {
      totalDocuments: 156,
      processedDocuments: 142,
      pendingDocuments: 14
    };
  });
</script>

<DashboardLayout>
  <div class="dashboard-content">

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="col-span-2">
        <MyAgents bind={myAgentsComponent} />
      </div>

      <div class="panel">
        <h2>Platform Connections</h2>
        <div class="connections-list">
          {#each activeConnections as connection}
            <div class="connection-card">
              <div class="connection-header">
                <h4>{connection.platform}</h4>
                <span class="status-badge connected">Connected</span>
              </div>
              <div class="connection-details">
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
            </div>
          {/each}
        </div>

        <h2 class="mt-6">Document Store</h2>
        <div class="document-stats">
          <div class="stat-row">
            <span>Total Documents</span>
            <span class="value">{documentStats.totalDocuments}</span>
          </div>
          <div class="stat-row">
            <span>Processed</span>
            <span class="value">{documentStats.processedDocuments}</span>
          </div>
          <div class="stat-row">
            <span>Pending</span>
            <span class="value">{documentStats.pendingDocuments}</span>
          </div>
          <div class="progress-bar">
            <div 
              class="progress" 
              style="width: {(documentStats.processedDocuments / documentStats.totalDocuments) * 100}%"
            ></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</DashboardLayout>

<style>
  .dashboard-content {
    padding: 1.5rem;
  }

  .stat-card {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .stat-card h3 {
    color: #64748b;
    font-size: 0.875rem;
    margin-bottom: 0.5rem;
  }

  .stat-value {
    color: #1e293b;
    font-size: 1.875rem;
    font-weight: 600;
  }

  .stat-desc {
    color: #64748b;
    font-size: 0.875rem;
    margin-top: 0.25rem;
  }

  .panel {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .panel h2 {
    color: #1e293b;
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
  }

  .connections-list {
    display: grid;
    gap: 1rem;
  }

  .connection-card {
    padding: 1rem;
    background: #f8fafc;
    border-radius: 6px;
  }

  .connection-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
  }

  .connection-header h4 {
    color: #1e293b;
    font-weight: 500;
    margin: 0;
  }

  .status-badge {
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
  }

  .status-badge.connected {
    background: #dcfce7;
    color: #166534;
  }

  .connection-details {
    color: #64748b;
    font-size: 0.875rem;
  }

  .document-stats {
    background: #f8fafc;
    padding: 1rem;
    border-radius: 6px;
  }

  .stat-row {
    display: flex;
    justify-content: space-between;
    color: #475569;
    font-size: 0.875rem;
    margin-bottom: 0.5rem;
  }

  .stat-row .value {
    font-weight: 500;
    color: #1e293b;
  }

  .progress-bar {
    width: 100%;
    height: 4px;
    background: #e2e8f0;
    border-radius: 2px;
    margin-top: 1rem;
    overflow: hidden;
  }

  .progress {
    height: 100%;
    background: #4f46e5;
    border-radius: 2px;
    transition: width 0.3s ease;
  }

  @media (max-width: 768px) {
    .agent-metrics {
      grid-template-columns: 1fr;
    }
  }
</style>
