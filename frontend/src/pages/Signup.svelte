<script>
  import { Link, navigate } from 'svelte-routing';
  import AuthLayout from '../components/AuthLayout.svelte';
  import { isAuthenticated, user } from '../stores/auth';

  let name = '';
  let email = '';
  let password = '';
  let confirmPassword = '';
  let agreeToTerms = false;
  let error = '';
  let loading = false;

  $: passwordsMatch = password === confirmPassword;

  async function handleDiscordSignup() {
    loading = true;
    error = '';

    try {
      // TODO: Replace with actual Discord OAuth flow
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Simulate successful signup
      isAuthenticated.set(true);
      user.set({
        name: 'Discord User',
        email: 'discord@example.com'
      });
      navigate('/dashboard');
    } catch (err) {
      error = err.message || 'An error occurred during Discord signup';
    } finally {
      loading = false;
    }
  }

  async function handleTelegramSignup() {
    loading = true;
    error = '';

    try {
      // TODO: Replace with actual Telegram OAuth flow
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Simulate successful signup
      isAuthenticated.set(true);
      user.set({
        name: 'Telegram User',
        email: 'telegram@example.com'
      });
      navigate('/dashboard');
    } catch (err) {
      error = err.message || 'An error occurred during Telegram signup';
    } finally {
      loading = false;
    }
  }

  async function handleSignup(e) {
    e.preventDefault();
    
    if (!passwordsMatch) {
      error = 'Passwords do not match';
      return;
    }

    if (!agreeToTerms) {
      error = 'Please agree to the terms and conditions';
      return;
    }

    loading = true;
    error = '';

    try {
      // TODO: Replace with actual API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Simulate successful signup
      isAuthenticated.set(true);
      user.set({
        email: email,
        name: name
      });
      navigate('/dashboard');
    } catch (err) {
      error = err.message || 'An error occurred';
    } finally {
      loading = false;
    }
  }
</script>

<AuthLayout>
  <div class="signup-form">
    <h1>Create your account</h1>
    <p class="subtitle">Start your 14-day free trial, no credit card required</p>

    <div class="social-signup">
      <button class="social-button discord" on:click|preventDefault={handleDiscordSignup} disabled={loading}>
        <img src="/icons/discord.svg" alt="Discord" />
        {#if loading}
          <span class="loader"></span>
        {:else}
          Sign up with Discord
        {/if}
      </button>
      <button class="social-button telegram" on:click|preventDefault={handleTelegramSignup} disabled={loading}>
        <img src="/icons/telegram.svg" alt="Telegram" />
        {#if loading}
          <span class="loader"></span>
        {:else}
          Sign up with Telegram
        {/if}
      </button>
      <div class="divider">
        <span>or sign up with email</span>
      </div>
    </div>

    {#if error}
      <div class="error-message">
        {error}
      </div>
    {/if}

    <form on:submit={handleSignup}>
      <div class="form-group">
        <label for="name">Full name</label>
        <input
          type="text"
          id="name"
          bind:value={name}
          placeholder="John Doe"
          required
        />
      </div>

      <div class="form-group">
        <label for="email">Work email</label>
        <input
          type="email"
          id="email"
          bind:value={email}
          placeholder="you@company.com"
          required
        />
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input
          type="password"
          id="password"
          bind:value={password}
          placeholder="Create a password"
          required
          minlength="8"
        />
      </div>

      <div class="form-group">
        <label for="confirm-password">Confirm password</label>
        <input
          type="password"
          id="confirm-password"
          bind:value={confirmPassword}
          placeholder="Confirm your password"
          required
          class:error={!passwordsMatch && confirmPassword}
        />
        {#if !passwordsMatch && confirmPassword}
          <span class="validation-error">Passwords do not match</span>
        {/if}
      </div>

      <div class="form-group">
        <label class="checkbox-label">
          <input
            type="checkbox"
            bind:checked={agreeToTerms}
          />
          <span>
            I agree to the <Link to="/terms">Terms of Service</Link> and <Link to="/privacy">Privacy Policy</Link>
          </span>
        </label>
      </div>

      <button type="submit" class="signup-button" disabled={loading}>
        {#if loading}
          <span class="loader"></span>
        {:else}
          Create account
        {/if}
      </button>
    </form>

    <div class="login-prompt">
      Already have an account? <Link to="/login">Sign in</Link>
    </div>
  </div>
</AuthLayout>

<style>
  .signup-form {
    width: 100%;
    max-width: 440px;
    padding: 2rem;
    background: white;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05),
                0 10px 15px rgba(0, 0, 0, 0.1);
  }

  .social-signup {
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

  input[type="text"],
  input[type="email"],
  input[type="password"] {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    font-size: 1rem;
    transition: border-color 0.2s;
  }

  input[type="text"]:focus,
  input[type="email"]:focus,
  input[type="password"]:focus {
    outline: none;
    border-color: #4a90e2;
    box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
  }

  input.error {
    border-color: #dc2626;
  }

  .validation-error {
    color: #dc2626;
    font-size: 0.875rem;
    margin-top: 0.5rem;
    display: block;
  }

  .checkbox-label {
    display: flex;
    align-items: flex-start;
    gap: 0.5rem;
    cursor: pointer;
  }

  .checkbox-label input[type="checkbox"] {
    width: 1rem;
    height: 1rem;
    margin-top: 0.25rem;
  }

  .checkbox-label span {
    color: #666;
    font-size: 0.9rem;
  }

  .checkbox-label a {
    color: #4a90e2;
    text-decoration: none;
  }

  .checkbox-label a:hover {
    text-decoration: underline;
  }

  .signup-button {
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

  .signup-button:hover {
    background: #357abd;
  }

  .signup-button:disabled {
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

  .login-prompt {
    text-align: center;
    margin-top: 2rem;
    color: #666;
  }

  .login-prompt a {
    color: #4a90e2;
    text-decoration: none;
  }

  .login-prompt a:hover {
    text-decoration: underline;
  }
</style>
