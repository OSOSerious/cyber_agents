<script>
  import { Link } from 'svelte-routing';
  import { fade } from 'svelte/transition';
</script>

<div class="not-found" in:fade>
  <div class="content">
    <h1>404</h1>
    <h2>Page Not Found</h2>
    <p>Oops! The page you're looking for doesn't exist.</p>
    <div class="actions">
      <Link to="/" class="primary-btn">Go Home</Link>
      <button class="secondary-btn" on:click={() => history.back()}>Go Back</button>
    </div>
  </div>
</div>

<style>
  .not-found {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    color: white;
    text-align: center;
    padding: 2rem;
  }

  .content {
    max-width: 600px;
  }

  h1 {
    font-size: 8rem;
    margin: 0;
    color: #4a90e2;
    line-height: 1;
  }

  h2 {
    font-size: 2.5rem;
    margin: 0 0 1rem;
  }

  p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    opacity: 0.8;
  }

  .actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
  }

  .primary-btn,
  .secondary-btn {
    padding: 0.8rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 1rem;
    cursor: pointer;
    transition: transform 0.2s, background-color 0.2s;
    border: none;
  }

  .primary-btn {
    background: #4a90e2;
    color: white;
  }

  .secondary-btn {
    background: rgba(255, 255, 255, 0.1);
    color: white;
  }

  .primary-btn:hover,
  .secondary-btn:hover {
    transform: translateY(-2px);
  }

  .primary-btn:hover {
    background: #357abd;
  }

  .secondary-btn:hover {
    background: rgba(255, 255, 255, 0.2);
  }

  @media (max-width: 480px) {
    h1 {
      font-size: 6rem;
    }

    h2 {
      font-size: 2rem;
    }

    .actions {
      flex-direction: column;
    }
  }
</style>
