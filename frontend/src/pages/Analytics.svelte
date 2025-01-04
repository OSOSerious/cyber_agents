<script>
  import { fade } from 'svelte/transition';
  import DashboardLayout from '../components/DashboardLayout.svelte';
</script>

<DashboardLayout>
  <div class="analytics" in:fade>
    <h1>Analytics Dashboard</h1>
    <div class="analytics-grid">
      <div class="card">
        <h3>Total Interactions</h3>
        <div class="metric">1,234</div>
      </div>
      <div class="card">
        <h3>Active Agents</h3>
        <div class="metric">12</div>
      </div>
      <div class="card">
        <h3>Success Rate</h3>
        <div class="metric">87%</div>
      </div>
      <div class="card">
        <h3>Response Time</h3>
        <div class="metric">1.2s</div>
      </div>
    </div>
    <div class="chart-section">
      <h2>Performance Overview</h2>
      <p>Detailed analytics and metrics coming soon...</p>
    </div>
  </div>
</DashboardLayout>

<style>
  .analytics {
    padding: 2rem;
  }

  h1 {
    margin-bottom: 2rem;
    color: #2d3748;
  }

  .analytics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
  }

  .card {
    background: white;
    padding: 1.5rem;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .card h3 {
    color: #4a5568;
    margin: 0 0 1rem 0;
    font-size: 1rem;
  }

  .metric {
    font-size: 2rem;
    font-weight: bold;
    color: #4f46e5;
  }

  .chart-section {
    background: white;
    padding: 2rem;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .chart-section h2 {
    color: #2d3748;
    margin: 0 0 1rem 0;
  }

  .chart-section p {
    color: #4a5568;
  }
</style>
