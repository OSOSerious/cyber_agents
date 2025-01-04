<script>
  import { fade } from 'svelte/transition';
  import DashboardLayout from '../components/DashboardLayout.svelte';
</script>

<DashboardLayout>
  <div class="deployments" in:fade>
    <h1>Agent Deployments</h1>
    <div class="deployments-grid">
      <div class="deployment-card">
        <div class="status active"></div>
        <div class="content">
          <h3>Customer Service Bot</h3>
          <p>Deployed on Website</p>
          <div class="metrics">
            <span>Uptime: 99.9%</span>
            <span>Requests: 1.2k/day</span>
          </div>
        </div>
      </div>
      
      <div class="deployment-card">
        <div class="status inactive"></div>
        <div class="content">
          <h3>Sales Assistant</h3>
          <p>Deployed on Discord</p>
          <div class="metrics">
            <span>Uptime: 0%</span>
            <span>Requests: 0/day</span>
          </div>
        </div>
      </div>

      <div class="deployment-card">
        <div class="status active"></div>
        <div class="content">
          <h3>Support Agent</h3>
          <p>Deployed on Telegram</p>
          <div class="metrics">
            <span>Uptime: 98.5%</span>
            <span>Requests: 800/day</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</DashboardLayout>

<style>
  .deployments {
    padding: 2rem;
  }

  h1 {
    margin-bottom: 2rem;
    color: #2d3748;
  }

  .deployments-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
  }

  .deployment-card {
    background: white;
    border-radius: 0.5rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    display: flex;
    gap: 1rem;
  }

  .status {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-top: 6px;
  }

  .status.active {
    background: #48bb78;
    box-shadow: 0 0 0 3px rgba(72, 187, 120, 0.2);
  }

  .status.inactive {
    background: #e53e3e;
    box-shadow: 0 0 0 3px rgba(229, 62, 62, 0.2);
  }

  .content {
    flex: 1;
  }

  .content h3 {
    color: #2d3748;
    margin: 0 0 0.5rem 0;
  }

  .content p {
    color: #4a5568;
    margin: 0 0 1rem 0;
  }

  .metrics {
    display: flex;
    gap: 1rem;
    font-size: 0.875rem;
    color: #718096;
  }

  .metrics span {
    background: #f7fafc;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
  }
</style>
