<script>
  import { Link } from "svelte-routing";
  import { onMount } from 'svelte';

  let isMenuOpen = false;
  let notifications = [];

  onMount(() => {
    // Simulated notifications
    notifications = [
      { id: 1, type: 'info', message: 'TechInsightAI deployed to Discord' },
      { id: 2, type: 'success', message: 'Document processing complete' },
      { id: 3, type: 'warning', message: 'NarrativeForge needs API key update' }
    ];
  });

  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
</script>

<div class="dashboard-content">
  <slot></slot>
</div>

<style>
  .dashboard-layout {
    display: flex;
    min-height: calc(100vh - 64px); /* Account for fixed nav */
    margin-top: -64px; /* Offset the main content margin */
  }

  .sidebar {
    width: 260px;
    background: #1e293b;
    color: white;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    transition: transform 0.3s ease;
  }

  .menu-toggle {
    display: none;
    background: none;
    border: none;
    color: white;
    cursor: pointer;
    margin-bottom: 1rem;
  }

  .nav-links {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .nav-link {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem;
    color: #94a3b8;
    text-decoration: none;
    border-radius: 6px;
    transition: all 0.2s;
  }

  .nav-link:hover {
    background: #2d3748;
    color: white;
  }

  .nav-link .icon {
    width: 20px;
    height: 20px;
  }

  .main-content {
    flex: 1;
    background: #f1f5f9;
    display: flex;
    flex-direction: column;
  }

  .top-bar {
    background: white;
    padding: 1rem 1.5rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .quick-actions {
    display: flex;
    gap: 1rem;
  }

  .action-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #4f46e5;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .action-btn:hover {
    background: #4338ca;
  }

  .action-btn .icon {
    width: 20px;
    height: 20px;
  }

  .notifications {
    display: flex;
    gap: 1rem;
  }

  .notification {
    padding: 0.5rem 1rem;
    border-radius: 6px;
    font-size: 0.875rem;
  }

  .notification.info {
    background: #dbeafe;
    color: #1e40af;
  }

  .notification.success {
    background: #dcfce7;
    color: #166534;
  }

  .notification.warning {
    background: #fef3c7;
    color: #92400e;
  }

  .content {
    flex: 1;
    padding: 1.5rem;
    height: calc(100vh - 64px); /* Account for top bar height */
    overflow-y: auto;
  }

  @media (max-width: 768px) {
    .sidebar {
      position: fixed;
      top: 0;
      bottom: 0;
      z-index: 50;
      transform: translateX(-100%);
    }

    .sidebar.open {
      transform: translateX(0);
    }

    .menu-toggle {
      display: block;
    }

    .main-content {
      margin-left: 0;
    }

    .top-bar {
      flex-direction: column;
      gap: 1rem;
    }

    .quick-actions {
      width: 100%;
      justify-content: space-between;
    }

    .notifications {
      width: 100%;
      flex-direction: column;
    }
  }
</style>
