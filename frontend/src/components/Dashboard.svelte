<script>
  import { onMount } from 'svelte';
  import { fade } from 'svelte/transition';
  import { user } from '../stores/auth';
  
  let campaigns = [];
  let selectedTags = [];
  let selectedCategories = [];
  let searchQuery = '';
  let loading = true;
  let stats = {
    totalCampaigns: 0,
    activeLeads: 0,
    conversionRate: 0,
    totalImpressions: 0
  };

  // Filter options
  const categories = ['B2B', 'B2C', 'Enterprise', 'Startup', 'E-commerce'];
  const tags = ['Cold Email', 'Follow-up', 'Newsletter', 'Promotion', 'Onboarding'];

  onMount(async () => {
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1000));
    campaigns = [
      {
        id: 1,
        name: 'Q4 Sales Drive',
        category: 'B2B',
        tags: ['Cold Email', 'Follow-up'],
        impressions: 1500,
        leads: 120,
        status: 'active'
      },
      // Add more sample campaigns
    ];
    stats = {
      totalCampaigns: 12,
      activeLeads: 450,
      conversionRate: 23,
      totalImpressions: 15000
    };
    loading = false;
  });

  function filterCampaigns() {
    return campaigns.filter(campaign => {
      const matchesSearch = campaign.name.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesCategory = selectedCategories.length === 0 || selectedCategories.includes(campaign.category);
      const matchesTags = selectedTags.length === 0 || campaign.tags.some(tag => selectedTags.includes(tag));
      return matchesSearch && matchesCategory && matchesTags;
    });
  }
</script>

<div class="dashboard-container" in:fade>
  <header class="dashboard-header">
    <div class="welcome-section">
      <h1>Welcome back, {$user?.email || 'User'}</h1>
      <p>Here's an overview of your campaigns</p>
    </div>
    
    <div class="stats-grid">
      <div class="stat-card">
        <h3>Total Campaigns</h3>
        <p class="stat-value">{stats.totalCampaigns}</p>
      </div>
      <div class="stat-card">
        <h3>Active Leads</h3>
        <p class="stat-value">{stats.activeLeads}</p>
      </div>
      <div class="stat-card">
        <h3>Conversion Rate</h3>
        <p class="stat-value">{stats.conversionRate}%</p>
      </div>
      <div class="stat-card">
        <h3>Total Impressions</h3>
        <p class="stat-value">{stats.totalImpressions}</p>
      </div>
    </div>
  </header>

  <main class="dashboard-main">
    <div class="filters-section">
      <input
        type="text"
        bind:value={searchQuery}
        placeholder="Search campaigns..."
        class="search-input"
      />
      
      <div class="filter-groups">
        <div class="filter-group">
          <h3>Categories</h3>
          <div class="filter-options">
            {#each categories as category}
              <label class="filter-option">
                <input
                  type="checkbox"
                  bind:group={selectedCategories}
                  value={category}
                />
                {category}
              </label>
            {/each}
          </div>
        </div>
        
        <div class="filter-group">
          <h3>Tags</h3>
          <div class="filter-options">
            {#each tags as tag}
              <label class="filter-option">
                <input
                  type="checkbox"
                  bind:group={selectedTags}
                  value={tag}
                />
                {tag}
              </label>
            {/each}
          </div>
        </div>
      </div>
    </div>

    <div class="campaigns-section">
      <div class="campaigns-header">
        <h2>Your Campaigns</h2>
        <button class="create-campaign-btn">Create New Campaign</button>
      </div>

      {#if loading}
        <div class="loading">Loading campaigns...</div>
      {:else}
        <div class="campaigns-grid">
          {#each filterCampaigns() as campaign}
            <div class="campaign-card">
              <div class="campaign-header">
                <h3>{campaign.name}</h3>
                <span class="status-badge {campaign.status}">{campaign.status}</span>
              </div>
              <div class="campaign-details">
                <p>Category: {campaign.category}</p>
                <div class="tags">
                  {#each campaign.tags as tag}
                    <span class="tag">{tag}</span>
                  {/each}
                </div>
              </div>
              <div class="campaign-stats">
                <div>
                  <span class="stat-label">Impressions</span>
                  <span class="stat-value">{campaign.impressions}</span>
                </div>
                <div>
                  <span class="stat-label">Leads</span>
                  <span class="stat-value">{campaign.leads}</span>
                </div>
              </div>
            </div>
          {/each}
        </div>
      {/if}
    </div>
  </main>
</div>

<style>
  .dashboard-container {
    min-height: 100vh;
    background: #f5f7fa;
    padding: 2rem;
  }

  .dashboard-header {
    margin-bottom: 2rem;
  }

  .welcome-section {
    margin-bottom: 2rem;
  }

  .welcome-section h1 {
    font-size: 2rem;
    color: #1a1a1a;
    margin-bottom: 0.5rem;
  }

  .welcome-section p {
    color: #666;
  }

  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
  }

  .stat-card {
    background: white;
    padding: 1.5rem;
    border-radius: 0.75rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  .stat-card h3 {
    color: #666;
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
  }

  .stat-card .stat-value {
    font-size: 1.5rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .dashboard-main {
    display: grid;
    grid-template-columns: 250px 1fr;
    gap: 2rem;
  }

  .filters-section {
    background: white;
    padding: 1.5rem;
    border-radius: 0.75rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  .search-input {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 0.5rem;
    margin-bottom: 1.5rem;
  }

  .filter-groups {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .filter-group h3 {
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 0.75rem;
  }

  .filter-options {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .filter-option {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #444;
    font-size: 0.9rem;
  }

  .campaigns-section {
    background: white;
    padding: 1.5rem;
    border-radius: 0.75rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  .campaigns-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
  }

  .create-campaign-btn {
    background: #4a90e2;
    color: white;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 0.5rem;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
  }

  .create-campaign-btn:hover {
    background: #357abd;
  }

  .campaigns-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 1.5rem;
  }

  .campaign-card {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 0.75rem;
    border: 1px solid #eee;
  }

  .campaign-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .status-badge {
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    font-weight: 500;
  }

  .status-badge.active {
    background: #e1f5e1;
    color: #2e7d32;
  }

  .campaign-details {
    margin-bottom: 1rem;
  }

  .tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-top: 0.5rem;
  }

  .tag {
    background: #e3f2fd;
    color: #1976d2;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: 0.8rem;
  }

  .campaign-stats {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #eee;
  }

  .stat-label {
    display: block;
    font-size: 0.8rem;
    color: #666;
  }

  .loading {
    text-align: center;
    color: #666;
    padding: 2rem;
  }
</style>