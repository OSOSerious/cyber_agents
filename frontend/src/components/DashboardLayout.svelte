<script>
  import { Link, navigate } from 'svelte-routing';
  import { fade } from 'svelte/transition';
  import { user, logout } from '../stores/auth';

  let isSidebarOpen = true;
  let isUserMenuOpen = false;

  function handleLogout() {
    logout();
    navigate('/login');
  }

  const menuItems = [
    {
      icon: '',
      label: 'Dashboard',
      path: '/dashboard'
    },
    {
      icon: '',
      label: 'Conversations',
      path: '/conversations'
    },
    {
      icon: '',
      label: 'Analytics',
      path: '/analytics'
    },
    {
      icon: '',
      label: 'Settings',
      path: '/settings'
    }
  ];
</script>

<div class="dashboard-layout" class:sidebar-collapsed={!isSidebarOpen}>
  <aside class="sidebar" class:collapsed={!isSidebarOpen}>
    <div class="sidebar-header">
      <Link to="/dashboard" class="brand">
        <img src="/logo.svg" alt="ContactingAI Logo" class="brand-logo" />
        {#if isSidebarOpen}
          <span class="brand-name">ContactingAI</span>
        {/if}
      </Link>
      <button class="collapse-btn" on:click={() => isSidebarOpen = !isSidebarOpen}>
        {#if isSidebarOpen}
          <span></span>
        {:else}
          <span></span>
        {/if}
      </button>
    </div>

    <nav class="sidebar-nav">
      {#each menuItems as item}
        <Link to={item.path} class="nav-item">
          <span class="nav-icon">{item.icon}</span>
          {#if isSidebarOpen}
            <span class="nav-label">{item.label}</span>
          {/if}
        </Link>
      {/each}
    </nav>
  </aside>

  <main class="main-content">
    <header class="top-bar">
      <div class="user-menu">
        <button 
          class="user-button"
          on:click={() => isUserMenuOpen = !isUserMenuOpen}
          aria-expanded={isUserMenuOpen}
          aria-haspopup="true"
        >
          <span class="user-avatar"></span>
          {#if isSidebarOpen}
            <span class="user-name">{$user?.name || 'User'}</span>
          {/if}
        </button>

        {#if isUserMenuOpen}
          <div 
            class="user-dropdown"
            transition:fade
            role="menu"
            aria-label="User menu"
          >
            <Link to="/profile" role="menuitem">Profile</Link>
            <Link to="/settings" role="menuitem">Settings</Link>
            <button on:click={handleLogout} role="menuitem">Logout</button>
          </div>
        {/if}
      </div>
    </header>

    <div class="content">
      <slot />
    </div>
  </main>
</div>

<style>
  .dashboard-layout {
    display: grid;
    grid-template-columns: auto 1fr;
    min-height: 100vh;
    background: #1a1a1a;
  }

  .sidebar {
    width: 240px;
    background: #222;
    border-right: 1px solid #333;
    transition: width 0.3s;
    overflow: hidden;
  }

  .sidebar.collapsed {
    width: 72px;
  }

  .sidebar-header {
    padding: 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #333;
  }

  .brand {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: white;
    text-decoration: none;
  }

  .brand-logo {
    width: 32px;
    height: 32px;
  }

  .brand-name {
    font-size: 1.2rem;
    font-weight: 500;
  }

  .collapse-btn {
    background: none;
    border: none;
    color: #666;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 0.25rem;
    transition: color 0.2s;
  }

  .collapse-btn:hover {
    color: white;
  }

  .sidebar-nav {
    padding: 1rem 0;
  }

  .nav-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 0.75rem 1rem;
    color: #999;
    text-decoration: none;
    transition: all 0.2s;
  }

  .nav-item:hover {
    background: #2a2a2a;
    color: white;
  }

  .nav-icon {
    font-size: 1.25rem;
    min-width: 24px;
    text-align: center;
  }

  .main-content {
    display: flex;
    flex-direction: column;
    background: #1a1a1a;
    color: white;
  }

  .top-bar {
    height: 64px;
    padding: 0 2rem;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    background: #222;
    border-bottom: 1px solid #333;
  }

  .user-menu {
    position: relative;
  }

  .user-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: none;
    border: none;
    color: white;
    padding: 0.5rem;
    cursor: pointer;
    border-radius: 0.25rem;
    transition: background-color 0.2s;
  }

  .user-button:hover {
    background: #2a2a2a;
  }

  .user-avatar {
    font-size: 1.25rem;
  }

  .user-name {
    font-size: 0.9rem;
  }

  .user-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    margin-top: 0.5rem;
    background: #222;
    border: 1px solid #333;
    border-radius: 0.5rem;
    min-width: 160px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    z-index: 100;
  }

  .user-dropdown a,
  .user-dropdown button {
    display: block;
    width: 100%;
    padding: 0.75rem 1rem;
    color: #999;
    text-decoration: none;
    background: none;
    border: none;
    text-align: left;
    cursor: pointer;
    transition: all 0.2s;
  }

  .user-dropdown a:hover,
  .user-dropdown button:hover {
    background: #2a2a2a;
    color: white;
  }

  .content {
    flex: 1;
    padding: 2rem;
    overflow-y: auto;
  }

  @media (max-width: 768px) {
    .dashboard-layout {
      grid-template-columns: 1fr;
    }

    .sidebar {
      position: fixed;
      left: 0;
      top: 0;
      bottom: 0;
      z-index: 1000;
      transform: translateX(-100%);
    }

    .sidebar.active {
      transform: translateX(0);
    }

    .top-bar {
      padding: 0 1rem;
    }

    .content {
      padding: 1rem;
    }
  }
</style>
