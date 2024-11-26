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
        navigate('/dashboard');
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
  <div class="login-form">
    <h1>Welcome back</h1>
    <p class="subtitle">Sign in to your account to continue</p>

    {#if error}
      <div class="error-message">
        {error}
      </div>
    {/if}

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
  .login-form {
    width: 100%;
    max-width: 400px;
  }

  h1 {
    font-size: 2rem;
    color: #1a1a1a;
    margin-bottom: 0.5rem;
  }

  .subtitle {
    color: #666;
    margin-bottom: 2rem;
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
    background: #4a90e2;
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 2.75rem;
  }

  .login-button:hover {
    background: #357abd;
  }

  .login-button:disabled {
    background: #93c5fd;
    cursor: not-allowed;
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
