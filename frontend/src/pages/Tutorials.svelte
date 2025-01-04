<script>
  import { fade } from 'svelte/transition';
  import DashboardLayout from '../components/DashboardLayout.svelte';
</script>

<DashboardLayout>
  <div class="tutorials" in:fade>
    <h1>Video Tutorials</h1>
    <div class="tutorials-grid">
      <div class="tutorial-card">
        <div class="thumbnail">
          <div class="placeholder">Tutorial Preview</div>
        </div>
        <div class="content">
          <h3>Getting Started with AI Agents</h3>
          <p>Learn the basics of creating and managing your AI agents.</p>
        </div>
      </div>
      <div class="tutorial-card">
        <div class="thumbnail">
          <div class="placeholder">Tutorial Preview</div>
        </div>
        <div class="content">
          <h3>Advanced Agent Configuration</h3>
          <p>Deep dive into customizing agent behavior and responses.</p>
        </div>
      </div>
      <div class="tutorial-card">
        <div class="thumbnail">
          <div class="placeholder">Tutorial Preview</div>
        </div>
        <div class="content">
          <h3>Integration Guide</h3>
          <p>How to integrate agents with your existing platforms.</p>
        </div>
      </div>
    </div>
  </div>
</DashboardLayout>

<style>
  .tutorials {
    padding: 2rem;
  }

  h1 {
    margin-bottom: 2rem;
    color: #2d3748;
  }

  .tutorials-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
  }

  .tutorial-card {
    background: white;
    border-radius: 0.5rem;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s;
  }

  .tutorial-card:hover {
    transform: translateY(-4px);
  }

  .thumbnail {
    background: #4f46e5;
    height: 180px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .placeholder {
    color: white;
    font-size: 1.2rem;
    opacity: 0.8;
  }

  .content {
    padding: 1.5rem;
  }

  .content h3 {
    color: #2d3748;
    margin: 0 0 0.5rem 0;
  }

  .content p {
    color: #4a5568;
    margin: 0;
    line-height: 1.5;
  }
</style>
