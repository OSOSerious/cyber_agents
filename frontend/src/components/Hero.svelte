<script>
  import { fade } from 'svelte/transition';
  import { Link } from 'svelte-routing';
</script>

<div class="landing-page" in:fade>
  <section class="hero-section">
    <div class="hero-content">
      <h1>Instant Customer Connection.<br/>Maximum Conversions.</h1>
      <p class="hero-subtitle">
        Stop waiting for emails. Transform your customer communication with instant, 
        AI-powered interactions that drive real results.
      </p>
      <div class="cta-buttons">
        <Link to="/signup" class="primary-btn">Get Started Free</Link>
        <a href="#demo" class="secondary-btn">Watch Demo</a>
      </div>
      <div class="hero-stats">
        <div class="stat">
          <span class="stat-number">3x</span>
          <span class="stat-label">Higher Conversion Rate</span>
        </div>
        <div class="stat">
          <span class="stat-number">90%</span>
          <span class="stat-label">Response Rate</span>
        </div>
        <div class="stat">
          <span class="stat-number">24/7</span>
          <span class="stat-label">Instant Support</span>
        </div>
      </div>
    </div>
  </section>

  <section class="how-it-works">
    <h2>How It Works</h2>
    <div class="steps-grid">
      <div class="step">
        <div class="step-number">1</div>
        <h3>Connect Instantly</h3>
        <p>Replace email delays with real-time customer interactions through AI or human agents.</p>
      </div>
      <div class="step">
        <div class="step-number">2</div>
        <h3>Engage Effectively</h3>
        <p>Use chat, voice, or SMS to communicate with customers on their preferred channel.</p>
      </div>
      <div class="step">
        <div class="step-number">3</div>
        <h3>Convert More</h3>
        <p>Turn more prospects into customers with immediate, personalized responses.</p>
      </div>
    </div>
  </section>

  <section class="demo-section" id="demo">
    <div class="demo-content">
      <div class="demo-text">
        <h2>See It In Action</h2>
        <p>Watch how ContactingAI transforms customer communication from delayed emails to instant interactions.</p>
        <ul class="demo-features">
          <li>Real-time customer engagement</li>
          <li>AI and human collaboration</li>
          <li>Multi-channel communication</li>
          <li>Instant response system</li>
        </ul>
        <Link to="/signup" class="primary-btn">Try It Free</Link>
      </div>
      <div class="demo-video">
        <div class="video-placeholder">
          <div class="play-button">▶</div>
          <span>Watch Demo</span>
        </div>
      </div>
    </div>
  </section>

  <section class="cta-section">
    <div class="cta-content">
      <h2>Ready to Transform Your Customer Communication?</h2>
      <p>Join thousands of businesses that have already eliminated email delays and boosted their conversion rates.</p>
      <div class="cta-buttons">
        <Link to="/signup" class="primary-btn">Start Free Trial</Link>
        <Link to="/pricing" class="secondary-btn">View Pricing</Link>
      </div>
    </div>
  </section>
</div>

<style>
  .landing-page {
    min-height: 100vh;
    background: #f5f7fa;
  }

  .hero-section {
    padding: 8rem 2rem 4rem;
    text-align: center;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    color: white;
  }

  .hero-content {
    max-width: 800px;
    margin: 0 auto;
  }

  .hero-content h1 {
    font-size: 3.5rem;
    margin-bottom: 1.5rem;
    line-height: 1.2;
    background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .hero-subtitle {
    font-size: 1.5rem;
    color: #ccc;
    margin-bottom: 2rem;
    line-height: 1.4;
  }

  .cta-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    margin-bottom: 3rem;
  }

  .primary-btn,
  .secondary-btn {
    padding: 1rem 2rem;
    border-radius: 0.5rem;
    font-weight: 500;
    text-decoration: none;
    transition: transform 0.2s;
    font-size: 1.1rem;
  }

  .primary-btn {
    background: #4a90e2;
    color: white;
  }

  .secondary-btn {
    background: rgba(255, 255, 255, 0.1);
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }

  .primary-btn:hover,
  .secondary-btn:hover {
    transform: translateY(-2px);
  }

  .hero-stats {
    display: flex;
    justify-content: center;
    gap: 4rem;
  }

  .stat {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .stat-number {
    font-size: 2.5rem;
    font-weight: 700;
    color: #4a90e2;
    margin-bottom: 0.5rem;
  }

  .stat-label {
    color: #ccc;
    font-size: 1rem;
  }

  .how-it-works {
    padding: 6rem 2rem;
    text-align: center;
  }

  .how-it-works h2 {
    font-size: 2.5rem;
    color: #1a1a1a;
    margin-bottom: 3rem;
  }

  .steps-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }

  .step {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .step-number {
    width: 3rem;
    height: 3rem;
    background: #4a90e2;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    font-weight: 600;
    margin: 0 auto 1rem;
  }

  .step h3 {
    color: #1a1a1a;
    margin-bottom: 1rem;
  }

  .step p {
    color: #666;
    line-height: 1.6;
  }

  .demo-section {
    padding: 6rem 2rem;
    background: white;
  }

  .demo-content {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
    align-items: center;
  }

  .demo-text h2 {
    font-size: 2.5rem;
    color: #1a1a1a;
    margin-bottom: 1rem;
  }

  .demo-text p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 2rem;
  }

  .demo-features {
    list-style: none;
    padding: 0;
    margin: 0 0 2rem;
  }

  .demo-features li {
    padding: 0.5rem 0;
    color: #666;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .demo-features li::before {
    content: "✓";
    color: #4a90e2;
    font-weight: bold;
  }

  .video-placeholder {
    background: #f5f7fa;
    border-radius: 1rem;
    aspect-ratio: 16/9;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: transform 0.2s;
  }

  .video-placeholder:hover {
    transform: translateY(-4px);
  }

  .play-button {
    width: 4rem;
    height: 4rem;
    background: #4a90e2;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    margin-bottom: 1rem;
  }

  .cta-section {
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    padding: 6rem 2rem;
    text-align: center;
    color: white;
  }

  .cta-content {
    max-width: 800px;
    margin: 0 auto;
  }

  .cta-content h2 {
    font-size: 2.5rem;
    margin-bottom: 1.5rem;
  }

  .cta-content p {
    font-size: 1.25rem;
    color: #ccc;
    margin-bottom: 2rem;
  }

  @media (max-width: 768px) {
    .hero-content h1 {
      font-size: 2.5rem;
    }

    .hero-subtitle {
      font-size: 1.25rem;
    }

    .hero-stats {
      flex-direction: column;
      gap: 2rem;
    }

    .demo-content {
      grid-template-columns: 1fr;
      text-align: center;
    }

    .demo-features {
      display: inline-block;
      text-align: left;
    }
  }
</style>
