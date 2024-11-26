<script>
  import Nav from './Nav.svelte';
  import { fade } from 'svelte/transition';
</script>

<div class="app-container" in:fade>
  <Nav />
  <main>
    <slot />
  </main>
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h3>ContactingAI</h3>
        <p>Transform your customer communication with instant, AI-powered interactions.</p>
        <div class="social-links">
          <a href="#" aria-label="Twitter">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
              <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/>
            </svg>
          </a>
          <a href="#" aria-label="LinkedIn">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
              <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/>
              <rect x="2" y="9" width="4" height="12"/>
              <circle cx="4" cy="4" r="2"/>
            </svg>
          </a>
        </div>
      </div>
      <div class="footer-section">
        <h4>Product</h4>
        <ul>
          <li><a href="/features">Features</a></li>
          <li><a href="/benefits">Benefits</a></li>
          <li><a href="/pricing">Pricing</a></li>
          <li><a href="/enterprise">Enterprise</a></li>
        </ul>
      </div>
      <div class="footer-section">
        <h4>Company</h4>
        <ul>
          <li><a href="/about">About Us</a></li>
          <li><a href="/careers">Careers</a></li>
          <li><a href="/blog">Blog</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </div>
      <div class="footer-section">
        <h4>Resources</h4>
        <ul>
          <li><a href="/documentation">Documentation</a></li>
          <li><a href="/support">Support</a></li>
          <li><a href="/privacy">Privacy Policy</a></li>
          <li><a href="/terms">Terms of Service</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; {new Date().getFullYear()} ContactingAI. All rights reserved.</p>
    </div>
  </footer>
</div>

<style>
  .app-container {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  main {
    flex: 1;
  }

  .footer {
    background: #1a1a1a;
    color: #fff;
    padding: 4rem 2rem 2rem;
    margin-top: 4rem;
  }

  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 2fr repeat(3, 1fr);
    gap: 4rem;
  }

  .footer-section h3 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #fff;
  }

  .footer-section h4 {
    font-size: 1.1rem;
    margin-bottom: 1rem;
    color: #fff;
  }

  .footer-section p {
    color: #ccc;
    margin-bottom: 1.5rem;
    line-height: 1.6;
  }

  .social-links {
    display: flex;
    gap: 1rem;
  }

  .social-links a {
    color: #ccc;
    transition: color 0.2s;
  }

  .social-links a:hover {
    color: #4a90e2;
  }

  .footer-section ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .footer-section ul li {
    margin-bottom: 0.5rem;
  }

  .footer-section ul a {
    color: #ccc;
    text-decoration: none;
    transition: color 0.2s;
  }

  .footer-section ul a:hover {
    color: #4a90e2;
  }

  .footer-bottom {
    max-width: 1200px;
    margin: 0 auto;
    padding-top: 2rem;
    margin-top: 2rem;
    border-top: 1px solid #333;
    text-align: center;
    color: #ccc;
  }

  @media (max-width: 768px) {
    .footer-content {
      grid-template-columns: 1fr;
      gap: 2rem;
    }

    .footer-section {
      text-align: center;
    }

    .social-links {
      justify-content: center;
    }
  }
</style>
