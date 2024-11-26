<script>
  import { onMount } from 'svelte';

  let productivityData = {
    emailCampaigns: 0,
    inboxManagement: 0,
    liveInteractions: 0
  };
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('/api/productivity');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      productivityData = await response.json();
    } catch (e) {
      console.error('Failed to fetch productivity data:', e);
      error = 'Failed to load productivity data. Please try again later.';
    } finally {
      loading = false;
    }
  });
</script>

<div class="automation-productivity">
  <h2>Boosting Productivity by Removing Email Dependency</h2>
  {#if loading}
    <p>Loading productivity data...</p>
  {:else if error}
    <p class="error">{error}</p>
  {:else}
    <div class="metrics-grid">
      <div class="metric-card">
        <h3>Email Campaigns Eliminated</h3>
        <p>{productivityData.emailCampaigns}</p>
      </div>
      <div class="metric-card">
        <h3>Inbox Management Time Saved</h3>
        <p>{productivityData.inboxManagement} hours</p>
      </div>
      <div class="metric-card">
        <h3>Live Interactions Focus</h3>
        <p>{productivityData.liveInteractions} hours</p>
      </div>
    </div>
  {/if}
</div>

<section>
  <h2>Boosting Productivity by Removing Email Dependency</h2>
  <p>By eliminating the need for email campaigns and inbox management, Contacting.AI frees up businesses to focus on live, impactful interactions that directly convert customers.</p>
</section>

<style>
  .automation-productivity {
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

  :global(.dark) .metric-card {
    background-color: #2a2a2a;
  }

  .error {
    color: #ff3e00;
    font-weight: bold;
  }
</style>
