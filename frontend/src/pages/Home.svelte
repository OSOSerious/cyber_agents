<script>
  import { Link } from "svelte-routing";
</script>

<div class="home">
  <div class="hero">
    <div class="hero-content">
      <h1>AI-Powered Communication Platform</h1>
      <p>Transform your customer interactions with intelligent, multi-channel communication</p>
      <div class="cta-buttons">
        <Link to="/signup" class="cta-button primary">Get Started</Link>
        <Link to="/features" class="cta-button secondary">Learn More</Link>
      </div>
    </div>
  </div>

  <section class="features">
    <h2>Why Choose ContactingAI?</h2>
    <div class="feature-grid">
      <div class="feature-card">
        <div class="feature-icon">🤖</div>
        <h3>AI-Powered Interactions</h3>
        <p>Smart routing and real-time analysis of customer interactions</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">💬</div>
        <h3>Multi-Channel Support</h3>
        <p>Seamless communication across chat, voice, and video</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">📊</div>
        <h3>Advanced Analytics</h3>
        <p>Deep insights into customer sentiment and interaction patterns</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🔄</div>
        <h3>Smart Handoff</h3>
        <p>Seamless transition between AI and human agents</p>
      </div>
    </div>
  </section>

  <section class="channels">
    <h2>Communication Channels</h2>
    <div class="channel-grid">
      <div class="channel-card">
        <span class="channel-icon">💬</span>
        <h3>Web Chat</h3>
        <p>Instant AI-powered web chat support</p>
      </div>
      <div class="channel-card">
        <span class="channel-icon">📞</span>
        <h3>Voice Calls</h3>
        <p>Smart voice interaction handling</p>
      </div>
      <div class="channel-card">
        <span class="channel-icon">🤳</span>
        <h3>Video Chat</h3>
        <p>Face-to-face customer support</p>
      </div>
      <div class="channel-card">
        <span class="channel-icon">📱</span>
        <h3>SMS/iMessage</h3>
        <p>Direct messaging integration</p>
      </div>
    </div>
  </section>
</div>

<style>
  .home {
    min-height: calc(100vh - 64px);
  }

  .hero {
    background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
    color: white;
    padding: 4em 2em;
    text-align: center;
  }

  .hero-content {
    max-width: 800px;
    margin: 0 auto;
  }

  .hero h1 {
    font-size: 3em;
    margin: 0 0 0.5em;
  }

  .hero p {
    font-size: 1.2em;
    margin: 0 0 2em;
    opacity: 0.9;
  }

  .cta-buttons {
    display: flex;
    gap: 1em;
    justify-content: center;
  }

  .cta-button {
    padding: 0.8em 1.5em;
    border-radius: 25px;
    font-weight: 500;
    text-decoration: none;
    transition: transform 0.2s;
  }

  .cta-button:hover {
    transform: translateY(-2px);
  }

  .cta-button.primary {
    background: white;
    color: #4f46e5;
  }

  .cta-button.secondary {
    border: 2px solid white;
    color: white;
  }

  section {
    padding: 4em 2em;
  }

  h2 {
    text-align: center;
    color: #2d3748;
    font-size: 2em;
    margin: 0 0 2em;
  }

  .feature-grid, .channel-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2em;
    max-width: 1200px;
    margin: 0 auto;
  }

  .feature-card, .channel-card {
    background: white;
    padding: 2em;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s;
  }

  .feature-card:hover, .channel-card:hover {
    transform: translateY(-5px);
  }

  .feature-icon, .channel-icon {
    font-size: 2.5em;
    margin-bottom: 0.5em;
  }

  h3 {
    color: #2d3748;
    margin: 0 0 0.5em;
  }

  p {
    color: #4a5568;
    margin: 0;
    line-height: 1.6;
  }

  .channels {
    background: #f7fafc;
  }

  @media (max-width: 768px) {
    .hero h1 {
      font-size: 2em;
    }

    .hero p {
      font-size: 1em;
    }

    .cta-buttons {
      flex-direction: column;
    }

    section {
      padding: 2em 1em;
    }
  }
</style>
