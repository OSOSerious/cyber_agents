<script>
  import { Router, Link, Route, navigate } from "svelte-routing";
  import { fade } from "svelte/transition";
  import { isAuthenticated, requireAuth, requireNoAuth } from "./stores/auth";
  import Layout from "./components/Layout.svelte";
  import Hero from "./components/Hero.svelte";
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
  <div class="app-container" in:fade>
    {#if $isAuthenticated}
      <Route 
        path="/dashboard" 
        component={Dashboard} 
        let:params
        let:location
      >
        {() => {
          requireAuth();
          return Dashboard;
        }}
      </Route>
      <Route 
        path="/conversations" 
        component={Conversations}
        let:params
        let:location
      >
        {() => {
          requireAuth();
          return Conversations;
        }}
      </Route>
      <!-- Redirect authenticated users trying to access auth pages -->
      <Route 
        path="/login" 
        component={Login}
        let:location
      >
        {() => {
          requireNoAuth();
          return Login;
        }}
      </Route>
      <Route 
        path="/signup" 
        component={Signup}
        let:location
      >
        {() => {
          requireNoAuth();
          return Signup;
        }}
      </Route>
    {:else}
      <Layout>
        <Route path="/" component={Hero} />
        <Route path="/features" component={Features} />
        <Route path="/benefits" component={Benefits} />
        <Route path="/pricing" component={Pricing} />
        <Route 
          path="/login" 
          component={Login}
          let:location
        >
          {() => {
            requireNoAuth();
            return Login;
          }}
        </Route>
        <Route 
          path="/signup" 
          component={Signup}
          let:location
        >
          {() => {
            requireNoAuth();
            return Signup;
          }}
        </Route>
      </Layout>
    {/if}
    <!-- Catch-all route for 404s -->
    <Route path="*" component={NotFound} />
  </div>
</Router>

<style>
  :global(body) {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }

  :global(*) {
    box-sizing: border-box;
  }

  :global(a) {
    color: inherit;
    text-decoration: none;
  }

  .app-container {
    min-height: 100vh;
  }
</style>
