<script>
  import { Link } from "svelte-routing";
</script>

<div class="home">
  <div class="hero">
    <div class="hero-content">
      <span class="hero-badge">AI-Powered Communication Platform</span>
      <h1>Transform Your Digital Presence with AI Agents</h1>
      <p>Automate customer engagement across Discord, Twitter, and Telegram with intelligent AI agents that understand your brand voice</p>
      <div class="stats-row">
        <div class="stat-item">
          <span class="stat-number">10k+</span>
          <span class="stat-label">Active Agents</span>
        </div>
        <div class="stat-item">
          <span class="stat-number">98%</span>
          <span class="stat-label">Response Rate</span>
        </div>
        <div class="stat-item">
          <span class="stat-number">24/7</span>
          <span class="stat-label">Availability</span>
        </div>
      </div>
      <div class="cta-buttons">
        <Link to="/signup" class="cta-button primary">Get Started Free</Link>
        <Link to="/login" class="cta-button secondary">Sign In</Link>
      </div>
    </div>
  </div>

  <section class="social-proof">
    <div class="platform-logos">
      <img src="/icons/discord.svg" alt="Discord" class="platform-logo" />
      <img src="/icons/telegram.svg" alt="Telegram" class="platform-logo" />
      <span class="platform-text">Trusted by leading communities across major platforms</span>
    </div>
  </section>

  <section class="features">
    <h2>Why Choose Our Platform?</h2>
    <div class="feature-grid">
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3>Instant Setup</h3>
        <p>Deploy your first AI agent in under 5 minutes with our intuitive interface</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🧠</div>
        <h3>Smart Learning</h3>
        <p>Agents learn from interactions to provide increasingly personalized responses</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">📊</div>
        <h3>Rich Analytics</h3>
        <p>Track engagement, response times, and satisfaction scores in real-time</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🔒</div>
        <h3>Enterprise Security</h3>
        <p>Bank-grade encryption and data protection for peace of mind</p>
      </div>
    </div>
  </section>

  <section class="testimonials">
    <h2>What Our Users Say</h2>
    <div class="testimonial-grid">
      <div class="testimonial-card">
        <div class="testimonial-content">
          <p>"Transformed our community management. Our Discord engagement increased by 300% within the first month."</p>
          <div class="testimonial-author">
            <strong>Sarah Chen</strong>
            <span>Community Manager, GamersUnite</span>
          </div>
        </div>
      </div>
      <div class="testimonial-card">
        <div class="testimonial-content">
          <p>"The AI agents handle 90% of routine inquiries, letting our team focus on strategic initiatives."</p>
          <div class="testimonial-author">
            <strong>Mark Thompson</strong>
            <span>Support Lead, TechStart</span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="cta-section">
    <div class="cta-content">
      <h2>Ready to Transform Your Digital Presence?</h2>
      <p>Join thousands of businesses already using our AI agents to scale their communication</p>
      <div class="cta-buttons final">
        <Link to="/signup" class="cta-button primary">Create Your First Agent</Link>
        <p class="no-credit-card">No credit card required</p>
      </div>
    </div>
  </section>
</div>

<style>
  .home {
    min-height: calc(100vh - 64px);
  }

  .hero {
    background: linear-gradient(135deg, #4f46e5 0%, #2563eb 100%);
    color: white;
    padding: 6em 2em;
    text-align: center;
    position: relative;
    overflow: hidden;
  }

  .hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('/background-pattern.svg') center/cover;
    opacity: 0.1;
  }

  .hero-content {
    max-width: 1000px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
  }

  .hero-badge {
    background: rgba(255, 255, 255, 0.1);
    padding: 0.5em 1em;
    border-radius: 20px;
    font-size: 0.9em;
    margin-bottom: 1em;
    display: inline-block;
  }

  .hero h1 {
    font-size: 3.5em;
    margin: 0 0 0.5em;
    line-height: 1.2;
  }

  .hero p {
    font-size: 1.3em;
    margin: 0 0 2em;
    opacity: 0.9;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
  }

  .stats-row {
    display: flex;
    justify-content: center;
    gap: 4em;
    margin-bottom: 2em;
  }

  .stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .stat-number {
    font-size: 2em;
    font-weight: bold;
    color: #fff;
  }

  .stat-label {
    font-size: 0.9em;
    opacity: 0.8;
  }

  .social-proof {
    background: #f8fafc;
    padding: 2em;
    text-align: center;
  }

  .platform-logos {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 2em;
  }

  .platform-logo {
    height: 2.5em;
    opacity: 0.7;
  }

  .platform-text {
    color: #64748b;
    font-size: 0.9em;
  }

  .cta-buttons {
    display: flex;
    gap: 1em;
    justify-content: center;
  }

  .cta-button {
    padding: 1em 2em;
    border-radius: 30px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    font-size: 1.1em;
  }

  .cta-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }

  .cta-button.primary {
    background: white;
    color: #4f46e5;
  }

  .cta-button.secondary {
    border: 2px solid white;
    color: white;
    backdrop-filter: blur(5px);
    background: rgba(255, 255, 255, 0.1);
  }

  section {
    padding: 6em 2em;
  }

  h2 {
    text-align: center;
    color: #1e293b;
    font-size: 2.5em;
    margin: 0 0 1.5em;
    font-weight: 700;
  }

  .testimonials {
    background: #f8fafc;
  }

  .testimonial-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2em;
    max-width: 1200px;
    margin: 0 auto;
  }

  .testimonial-card {
    background: white;
    padding: 2em;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .testimonial-content p {
    font-size: 1.1em;
    color: #334155;
    line-height: 1.6;
    margin-bottom: 1em;
  }

  .testimonial-author {
    display: flex;
    flex-direction: column;
    gap: 0.2em;
  }

  .testimonial-author strong {
    color: #1e293b;
  }

  .testimonial-author span {
    color: #64748b;
    font-size: 0.9em;
  }

  .cta-section {
    background: linear-gradient(135deg, #4f46e5 0%, #2563eb 100%);
    color: white;
    text-align: center;
  }

  .cta-content {
    max-width: 800px;
    margin: 0 auto;
  }

  .cta-content h2 {
    color: white;
    margin-bottom: 0.5em;
  }

  .cta-content p {
    font-size: 1.2em;
    margin-bottom: 2em;
    opacity: 0.9;
  }

  .cta-buttons.final {
    flex-direction: column;
    align-items: center;
  }

  .no-credit-card {
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.9em;
    margin-top: 1em;
    margin-bottom: 0;
  }

  .feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2em;
    max-width: 1200px;
    margin: 0 auto;
  }

  .feature-card {
    background: white;
    padding: 2.5em;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    border: 1px solid #e2e8f0;
  }

  .feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
  }

  .feature-icon {
    font-size: 3em;
    margin-bottom: 0.5em;
    display: inline-block;
  }

  .feature-card h3 {
    color: #1e293b;
    font-size: 1.5em;
    margin: 0 0 0.5em;
    font-weight: 600;
  }

  .feature-card p {
    color: #64748b;
    margin: 0;
    line-height: 1.6;
    font-size: 1.1em;
  }

  @media (max-width: 768px) {
    .hero {
      padding: 4em 1em;
    }

    .hero h1 {
      font-size: 2.5em;
    }

    .hero p {
      font-size: 1.1em;
    }

    .stats-row {
      flex-direction: column;
      gap: 2em;
    }

    .platform-logos {
      flex-direction: column;
      gap: 1.5em;
    }

    .cta-buttons {
      flex-direction: column;
    }

    section {
      padding: 4em 1em;
    }

    h2 {
      font-size: 2em;
    }
  }
</style>
