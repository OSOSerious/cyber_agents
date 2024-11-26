<script>
  import { Link } from 'svelte-routing';
</script>

<nav class="nav">
  <div class="nav-content">
    <div class="nav-brand">
      <Link to="/">
        <img src="/logo.svg" alt="ContactingAI Logo" class="nav-logo" />
        <span class="brand-name">ContactingAI</span>
      </Link>
    </div>
    <div class="nav-links">
      <Link to="/features">Features</Link>
      <Link to="/benefits">Benefits</Link>
      <Link to="/pricing">Pricing</Link>
      <Link to="/login" class="login-btn">Login</Link>
      <Link to="/signup" class="signup-btn">Start Free Trial</Link>
    </div>
  </div>
</nav>

<style>
  .nav {
    background: white;
    padding: 1rem 2rem;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 100;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  .nav-content {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .nav-brand {
    display: flex;
    align-items: center;
  }

  .nav-brand a {
    display: flex;
    align-items: center;
    gap: 1rem;
    text-decoration: none;
  }

  .nav-logo {
    height: 2rem;
    width: auto;
  }

  .brand-name {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 2rem;
  }

  .nav-links a {
    text-decoration: none;
    color: #666;
    font-weight: 500;
    transition: color 0.2s;
  }

  .nav-links a:hover {
    color: #4a90e2;
  }

  .login-btn {
    color: #4a90e2 !important;
  }

  .signup-btn {
    background: #4a90e2;
    color: white !important;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    transition: background-color 0.2s !important;
  }

  .signup-btn:hover {
    background: #357abd;
  }

  @media (max-width: 768px) {
    .nav-links {
      display: none;
    }
  }
</style>
