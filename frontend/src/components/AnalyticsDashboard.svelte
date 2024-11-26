<script>
  import { onMount } from 'svelte';

  let analyticsData = {
    totalContacts: 0,
    totalInteractions: 0,
    conversionRate: 0,
    recentActivity: []
  };
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('/api/analytics');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      analyticsData = await response.json();
    } catch (e) {
      console.error('Failed to fetch analytics data:', e);
      error = 'Failed to load analytics data. Please try again later.';
    } finally {
      loading = false;
    }
  });
</script>

<div class="analytics-dashboard">
  <h2>Analytics Dashboard</h2>
  {#if loading}
    <p>Loading analytics data...</p>
  {:else if error}
    <p class="error">{error}</p>
  {:else}
    <div class="metrics-grid">
      <div class="metric-card">
        <h3>Total Contacts</h3>
        <p>{analyticsData.totalContacts}</p>
      </div>
      <div class="metric-card">
        <h3>Total Interactions</h3>
        <p>{analyticsData.totalInteractions}</p>
      </div>
      <div class="metric-card">
        <h3>Conversion Rate</h3>
        <p>{analyticsData.conversionRate}%</p>
      </div>
    </div>
    <div class="recent-activity">
      <h3>Recent Activity</h3>
      {#if analyticsData.recentActivity.length > 0}
        <ul>
          {#each analyticsData.recentActivity as activity}
            <li>{activity}</li>
          {/each}
        </ul>
      {:else}
        <p>No recent activity to display.</p>
      {/if}
    </div>
  {/if}
</div>

<section>
  <h2>Real-Time Performance Tracking and Optimization</h2>
  <p>Contacting.AI offers real-time analytics on interaction performance, tracking conversions, engagement time, and customer satisfaction without the limitations of email open or click rates.</p>
</section>

<style>
  .analytics-dashboard {
    padding: 1rem;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .metric-card {
    background-color: #f0f0f0;
    border-radius: 8px;
    padding: 1rem;
    text-align: center;
  }

  .metric-card h3 {
    margin-top: 0;
  }

  .metric-card p {
    font-size: 2rem;
    font-weight: bold;
    margin: 0;
  }

  .recent-activity ul {
    list-style-type: none;
    padding: 0;
  }

  .recent-activity li {
    margin-bottom: 0.5rem;
  }

  :global(.dark) .metric-card {
    background-color: #2a2a2a;
  }

  .error {
    color: #ff3e00;
    font-weight: bold;
  }
</style>
