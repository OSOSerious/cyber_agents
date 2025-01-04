<script>
  import { Router, Link, Route, navigate } from "svelte-routing";
  import { onMount } from "svelte";
  import { isAuthenticated } from "./stores/auth";
  import Home from "./pages/Home.svelte";
  import Login from "./pages/Login.svelte";
  import Signup from "./pages/Signup.svelte";
  import Dashboard from "./pages/Dashboard.svelte";
  import MyAgents from "./components/MyAgents.svelte";
  import DashboardLayout from "./components/DashboardLayout.svelte";
  import Conversations from './pages/Conversations.svelte';
  import NotFound from './pages/NotFound.svelte';
  import CharacterBuilder from './pages/CharacterBuilder.svelte';
  import Templates from "./components/Templates.svelte";
  import AgentProfile from "./pages/AgentProfile.svelte";
  import Analytics from "./pages/Analytics.svelte";
  import Tutorials from "./pages/Tutorials.svelte";
  import Deployments from "./pages/Deployments.svelte";

  export let url = "";

  // Protected routes that require authentication
  const protectedRoutes = [
    '/agents',
    '/templates',
    '/deployments', 
    '/analytics',
    '/tutorials',
    '/character-builder',
    '/dashboard',
    '/conversations'
  ];

  // Check if current route is protected
  function isProtectedRoute(path) {
    return protectedRoutes.some(route => path.startsWith(route));
  }

  // Handle route protection
  function handleNavigation(event) {
    const path = new URL(event.detail.href).pathname;
    if (isProtectedRoute(path) && !$isAuthenticated) {
      event.preventDefault();
      navigate('/login');
    }
  }

  onMount(() => {
    // Check current path on mount
    if (isProtectedRoute(window.location.pathname) && !$isAuthenticated) {
      navigate('/login');
    }
  });
</script>

<Router {url} on:navigate={handleNavigation}>
  <nav>
    <div class="nav-left">
      <Link to="/" class="logo">AI Agent Studio</Link>
      {#if $isAuthenticated}
        <Link to="/agents">My Agents</Link>
        <Link to="/templates">Templates</Link>
        <Link to="/deployments">Deployments</Link>
        <Link to="/analytics">Analytics</Link>
        <Link to="/tutorials">Tutorials</Link>
        <Link to="/character-builder">Create Agent</Link>
      {/if}
    </div>
    <div class="nav-right">
      {#if $isAuthenticated}
        <button class="auth-link" on:click={() => {
          isAuthenticated.set(false);
          navigate('/');
        }}>Logout</button>
      {:else}
        <Link to="/login" class="auth-link">Login</Link>
        <Link to="/signup" class="auth-link signup">Sign Up</Link>
      {/if}
    </div>
  </nav>

  <main>
    <Route path="/" component={Home} />
    <Route path="/login" component={Login} />
    <Route path="/signup" component={Signup} />
    {#if $isAuthenticated}
      <Route path="/agents" let:params>
        <DashboardLayout>
          <MyAgents />
        </DashboardLayout>
      </Route>
      <Route path="/agents/:id" let:params>
        <DashboardLayout>
          <AgentProfile agentId={params.id} />
        </DashboardLayout>
      </Route>
      <Route path="/templates">
        <DashboardLayout>
          <Templates />
        </DashboardLayout>
      </Route>
      <Route path="/deployments">
        <DashboardLayout>
          <Deployments />
        </DashboardLayout>
      </Route>
      <Route path="/analytics">
        <DashboardLayout>
          <Analytics />
        </DashboardLayout>
      </Route>
      <Route path="/tutorials">
        <DashboardLayout>
          <Tutorials />
        </DashboardLayout>
      </Route>
      <Route path="/dashboard">
        <DashboardLayout>
          <Dashboard />
        </DashboardLayout>
      </Route>
      <Route path="/conversations">
        <DashboardLayout>
          <Conversations />
        </DashboardLayout>
      </Route>
      <Route path="/character-builder">
        <DashboardLayout>
          <CharacterBuilder />
        </DashboardLayout>
      </Route>
    {/if}
    <Route path="*" let:params>
      <NotFound />
    </Route>
  </main>
</Router>

<style>
  :global(body) {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
    background: #f7fafc;
  }

  nav {
    background: white;
    padding: 1em 2em;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 100;
  }

  .nav-left, .nav-right {
    display: flex;
    align-items: center;
    gap: 2em;
  }

  .logo {
    font-weight: 700;
    font-size: 1.2em;
    color: #4f46e5;
    text-decoration: none;
  }

  :global(nav a) {
    color: #4a5568;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
  }

  :global(nav a:hover) {
    color: #4f46e5;
  }

  .auth-link {
    padding: 0.5em 1em;
    border-radius: 20px;
    transition: all 0.2s;
    border: none;
    font-size: 1em;
    font-weight: 500;
    cursor: pointer;
    background: none;
    color: #4a5568;
  }

  .auth-link:hover {
    color: #4f46e5;
  }

  .auth-link.signup {
    background: #4f46e5;
    color: white;
  }

  .auth-link.signup:hover {
    background: #4338ca;
    color: white;
  }

  main {
    min-height: calc(100vh - 64px);
    margin-top: 64px; /* Account for fixed nav */
  }

  nav {
    position: fixed;
    width: 100%;
    top: 0;
    left: 0;
    z-index: 1000;
  }

  @media (max-width: 768px) {
    nav {
      padding: 1em;
    }

    .nav-left, .nav-right {
      gap: 1em;
    }

    :global(nav a) {
      font-size: 0.9em;
    }
  }
</style>
