<script>
  import { login } from '../stores/auth';
  import { navigate } from 'svelte-routing';
  
  let email = '';
  let password = '';
  let error = '';
  let loading = false;

  async function handleLogin() {
    loading = true;
    error = '';
    
    try {
      // Replace with actual API call
      await new Promise(resolve => setTimeout(resolve, 1000));
      login({ email });
      navigate('/dashboard');
    } catch (err) {
      error = 'Invalid credentials';
    } finally {
      loading = false;
    }
  }
</script>

<div class="login-container" in:fade>
  <div class="login-card">
    <div class="login-header">
      <h1>Welcome Back</h1>
      <p>Sign in to access your campaigns</p>
    </div>
    
    <form on:submit|preventDefault={handleLogin} class="login-form">
      <div class="form-group">
        <label for="email">Email</label>
        <input 
          type="email" 
          id="email" 
          bind:value={email} 
          placeholder="Enter your email"
          required
        />
      </div>
      
      <div class="form-group">
        <label for="password">Password</label>
        <input 
          type="password" 
          id="password" 
          bind:value={password} 
          placeholder="Enter your password"
          required
        />
      </div>
      
      {#if error}
        <div class="error-message">{error}</div>
      {/if}
      
      <button type="submit" class="login-button" disabled={loading}>
        {#if loading}
          Loading...
        {:else}
          Sign In
        {/if}
      </button>
      
      <div class="login-footer">
        <a href="/forgot-password">Forgot Password?</a>
        <span>•</span>
        <a href="/signup">Create Account</a>
      </div>
    </form>
  </div>
</div>

<style>
  .login-container {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    padding: 2rem;
  }

  .login-card {
    background: white;
    padding: 2.5rem;
    border-radius: 1rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
  }

  .login-header {
    text-align: center;
    margin-bottom: 2rem;
  }

  .login-header h1 {
    color: #1a1a1a;
    font-size: 2rem;
    margin-bottom: 0.5rem;
  }

  .login-header p {
    color: #666;
  }

  .login-form {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .form-group label {
    color: #444;
    font-weight: 500;
  }

  .form-group input {
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 0.5rem;
    font-size: 1rem;
    transition: border-color 0.2s;
  }

  .form-group input:focus {
    border-color: #4a90e2;
    outline: none;
  }

  .error-message {
    color: #e74c3c;
    font-size: 0.9rem;
    text-align: center;
  }

  .login-button {
    background: #4a90e2;
    color: white;
    padding: 0.75rem;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .login-button:hover {
    background: #357abd;
  }

  .login-button:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .login-footer {
    display: flex;
    justify-content: center;
    gap: 1rem;
    align-items: center;
    margin-top: 1rem;
  }

  .login-footer a {
    color: #4a90e2;
    text-decoration: none;
    font-size: 0.9rem;
  }

  .login-footer span {
    color: #ddd;
  }
</style>