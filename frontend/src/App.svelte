<script>
  import { Router, Link, Route } from "svelte-routing";
  import Home from "./pages/Home.svelte";
  import Features from "./pages/Features.svelte";
  import Benefits from "./pages/Benefits.svelte";
  import Pricing from "./pages/Pricing.svelte";
  import Login from "./pages/Login.svelte";
  import Signup from "./pages/Signup.svelte";
  import Dashboard from "./pages/Dashboard.svelte";
  import Conversations from './pages/Conversations.svelte';
  import NotFound from './pages/NotFound.svelte';

  export let url = "";
</script>

<Router {url}>
  <nav>
    <div class="nav-left">
      <Link to="/" class="logo">ContactingAI</Link>
      <Link to="/features">Features</Link>
      <Link to="/benefits">Benefits</Link>
      <Link to="/pricing">Pricing</Link>
    </div>
    <div class="nav-right">
      <Link to="/login" class="auth-link">Login</Link>
      <Link to="/signup" class="auth-link signup">Sign Up</Link>
    </div>
  </nav>

  <main>
    <Route path="/" component={Home} />
    <Route path="/features" component={Features} />
    <Route path="/benefits" component={Benefits} />
    <Route path="/pricing" component={Pricing} />
    <Route path="/login" component={Login} />
    <Route path="/signup" component={Signup} />
    <Route path="/dashboard" component={Dashboard} />
    <Route path="/conversations" component={Conversations} />
    <Route path="*" component={NotFound} />
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
