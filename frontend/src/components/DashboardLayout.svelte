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

<div class="dashboard-layout">
  <nav class="sidebar {isMenuOpen ? 'open' : ''}">
    <button class="menu-toggle" on:click={toggleMenu}>
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="w-6 h-6">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
      </svg>
    </button>

    <div class="nav-links">
      <Link to="/dashboard" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z" />
        </svg>
        Dashboard
      </Link>

      <Link to="/character-builder" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z" />
        </svg>
        AI Agents
      </Link>

      <Link to="/templates" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z" />
        </svg>
        Templates
      </Link>

      <Link to="/documents" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z" clip-rule="evenodd" />
        </svg>
        Documents
      </Link>

      <Link to="/platforms" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M2 5a2 2 0 012-2h12a2 2 0 012 2v10a2 2 0 01-2 2H4a2 2 0 01-2-2V5zm3.293 1.293a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 01-1.414-1.414L7.586 10 5.293 7.707a1 1 0 010-1.414zM11 12a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd" />
        </svg>
        Platforms
      </Link>

      <Link to="/settings" class="nav-link">
        <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd" />
        </svg>
        Settings
      </Link>
    </div>
  </nav>

  <div class="main-content">
    <header class="top-bar">
      <div class="quick-actions">
        <button class="action-btn">
          <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
          </svg>
          Deploy Agent
        </button>
        <button class="action-btn">
          <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM6.293 6.707a1 1 0 010-1.414l3-3a1 1 0 011.414 0l3 3a1 1 0 01-1.414 1.414L11 5.414V13a1 1 0 11-2 0V5.414L7.707 6.707a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
          Upload Documents
        </button>
      </div>

      <div class="notifications">
        {#each notifications as notification}
          <div class="notification {notification.type}">
            {notification.message}
          </div>
        {/each}
      </div>
    </header>

    <main class="content">
      <slot></slot>
    </main>
  </div>
</div>

<style>
  .dashboard-layout {
    display: flex;
    min-height: 100vh;
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
