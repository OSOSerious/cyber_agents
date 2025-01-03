<script>
  import { Link } from 'svelte-routing';
  import { fade } from 'svelte/transition';
</script>

<div class="auth-container" in:fade>
  <div class="auth-content">
    <div class="auth-left">
      <Link to="/" class="brand">
        <span class="brand-name">AI Agent Studio</span>
      </Link>
      <div class="auth-form-container">
        <slot />
      </div>
    </div>
    <div class="auth-right">
      <div class="testimonial">
        <div class="quote">"Our AI agents have revolutionized how we interact with customers, providing instant, intelligent responses 24/7."</div>
        <div class="author">
          <img src="/testimonial-avatar.jpg" alt="Sarah Johnson" class="author-image" />
          <div class="author-info">
            <div class="author-name">Sarah Johnson</div>
            <div class="author-title">Head of Sales, TechCorp</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .auth-container {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    background: #f5f7fa;
  }

  .auth-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    max-width: 1200px;
    width: 100%;
    background: white;
    border-radius: 1rem;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .auth-left {
    padding: 3rem;
    display: flex;
    flex-direction: column;
  }

  .brand {
    display: flex;
    align-items: center;
    gap: 1rem;
    text-decoration: none;
    margin-bottom: 3rem;
  }

  .brand-name {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .auth-form-container {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .auth-right {
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    padding: 3rem;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
  }

  .testimonial {
    max-width: 400px;
  }

  .quote {
    font-size: 1.5rem;
    line-height: 1.4;
    margin-bottom: 2rem;
    font-weight: 500;
  }

  .author {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .author-image {
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    object-fit: cover;
  }

  .author-name {
    font-weight: 600;
    margin-bottom: 0.25rem;
  }

  .author-title {
    color: #ccc;
    font-size: 0.9rem;
  }

  @media (max-width: 768px) {
    .auth-content {
      grid-template-columns: 1fr;
    }

    .auth-right {
      display: none;
    }

    .auth-left {
      padding: 2rem;
    }
  }
</style>
