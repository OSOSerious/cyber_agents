<script>
  import { Link, navigate } from 'svelte-routing';
  import AuthLayout from '../components/AuthLayout.svelte';
  import { isAuthenticated, user } from '../stores/auth';

  let email = '';
  let password = '';
  let rememberMe = false;
  let error = '';
  let loading = false;

  async function handleLogin(e) {
    e.preventDefault();
    loading = true;
    error = '';

    try {
      // TODO: Replace with actual API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      if (email === 'demo@example.com' && password === 'password') {
        isAuthenticated.set(true);
        user.set({
          email: email,
          name: 'Demo User'
        });
        navigate('/agents');
      } else {
        error = 'Invalid email or password';
      }
    } catch (err) {
      error = err.message || 'An error occurred';
    } finally {
      loading = false;
    }
  }
</script>

<AuthLayout>
  <div class="login-container">
    <div class="login-header">
      <img src="/logo.svg" alt="Logo" class="logo" />
      <h1>Welcome back</h1>
      <p class="subtitle">Access your AI agents and analytics</p>
    </div>

    {#if error}
      <div class="error-message">
        {error}
      </div>
    {/if}

    <div class="social-login">
      <button class="social-button discord">
        <img src="/icons/discord.svg" alt="Discord" />
        Continue with Discord
      </button>
      <button class="social-button telegram">
        <img src="/icons/telegram.svg" alt="Telegram" />
        Continue with Telegram
      </button>
      <div class="divider">
        <span>or continue with email</span>
      </div>
    </div>

    <form on:submit={handleLogin}>
      <div class="form-group">
        <label for="email">Email address</label>
        <input
          type="email"
          id="email"
          bind:value={email}
          placeholder="you@company.com"
          required
        />
      </div>

      <div class="form-group">
        <div class="password-header">
          <label for="password">Password</label>
          <Link to="/forgot-password" class="forgot-link">Forgot password?</Link>
        </div>
        <input
          type="password"
          id="password"
          bind:value={password}
          placeholder="Enter your password"
          required
        />
      </div>

      <div class="form-group">
        <label class="checkbox-label">
          <input
            type="checkbox"
            bind:checked={rememberMe}
          />
          <span>Remember me</span>
        </label>
      </div>

      <button type="submit" class="login-button" disabled={loading}>
        {#if loading}
          <span class="loader"></span>
        {:else}
          Sign in
        {/if}
      </button>
    </form>

    <div class="signup-prompt">
      Don't have an account? <Link to="/signup">Sign up</Link>
    </div>
  </div>
</AuthLayout>

<style>
  .login-container {
    width: 100%;
    max-width: 440px;
    padding: 2rem;
    background: white;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05),
                0 10px 15px rgba(0, 0, 0, 0.1);
  }

  .login-header {
    text-align: center;
    margin-bottom: 2rem;
  }

  .logo {
    width: 80px;
    height: 80px;
    margin-bottom: 1.5rem;
  }

  h1 {
    font-size: 2rem;
    color: #1a1a1a;
    margin-bottom: 0.5rem;
    font-weight: 700;
  }

  .subtitle {
    color: #666;
    margin-bottom: 2rem;
    font-size: 1.1rem;
  }

  .social-login {
    margin-bottom: 2rem;
  }

  .social-button {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    background: white;
    color: #1a1a1a;
    font-size: 1rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    cursor: pointer;
    transition: all 0.2s;
    margin-bottom: 1rem;
  }

  .social-button:hover {
    background: #f9fafb;
    border-color: #d1d5db;
  }

  .social-button img {
    width: 24px;
    height: 24px;
  }

  .social-button.discord {
    background: #5865F2;
    border-color: #5865F2;
    color: white;
  }

  .social-button.discord:hover {
    background: #4752c4;
  }

  .social-button.telegram {
    background: #0088cc;
    border-color: #0088cc;
    color: white;
  }

  .social-button.telegram:hover {
    background: #0077b3;
  }

  .divider {
    position: relative;
    text-align: center;
    margin: 1.5rem 0;
  }

  .divider::before,
  .divider::after {
    content: '';
    position: absolute;
    top: 50%;
    width: calc(50% - 4rem);
    height: 1px;
    background: #e5e7eb;
  }

  .divider::before {
    left: 0;
  }

  .divider::after {
    right: 0;
  }

  .divider span {
    background: white;
    padding: 0 1rem;
    color: #6b7280;
    font-size: 0.9rem;
  }

  .error-message {
    background: #fee2e2;
    color: #dc2626;
    padding: 1rem;
    border-radius: 0.5rem;
    margin-bottom: 1rem;
  }

  .form-group {
    margin-bottom: 1.5rem;
  }

  label {
    display: block;
    color: #1a1a1a;
    font-weight: 500;
    margin-bottom: 0.5rem;
  }

  .password-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
  }

  .forgot-link {
    color: #4a90e2;
    font-size: 0.9rem;
    text-decoration: none;
  }

  .forgot-link:hover {
    text-decoration: underline;
  }

  input[type="email"],
  input[type="password"] {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    font-size: 1rem;
    transition: border-color 0.2s;
  }

  input[type="email"]:focus,
  input[type="password"]:focus {
    outline: none;
    border-color: #4a90e2;
    box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
  }

  .checkbox-label input[type="checkbox"] {
    width: 1rem;
    height: 1rem;
  }

  .login-button {
    width: 100%;
    padding: 0.75rem;
    background: linear-gradient(135deg, #4f46e5 0%, #2563eb 100%);
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 2.75rem;
  }

  .login-button:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
  }

  .login-button:disabled {
    background: linear-gradient(135deg, #6366f1 0%, #3b82f6 100%);
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
  }

  .loader {
    width: 1.25rem;
    height: 1.25rem;
    border: 2px solid #ffffff;
    border-top-color: transparent;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  .signup-prompt {
    text-align: center;
    margin-top: 2rem;
    color: #666;
  }

  .signup-prompt a {
    color: #4a90e2;
    text-decoration: none;
  }

  .signup-prompt a:hover {
    text-decoration: underline;
  }
</style>
