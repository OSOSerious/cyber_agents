<script>
  import { fade } from 'svelte/transition';
</script>

<div class="benefits-page" in:fade>
  <section class="benefits-hero">
    <h1>Transform Your Customer Communication</h1>
    <p class="subtitle">See how ContactingAI revolutionizes customer engagement with real-time, AI-powered interactions</p>
  </section>

  <section class="benefits-grid">
    <div class="benefit-card">
      <h3>Replace Email Delays</h3>
      <p>Eliminate the waiting game. Engage customers instantly when their interest is highest.</p>
      <div class="comparison">
        <div class="before">
          <span class="label">Before</span>
          <span class="value">24hr Response</span>
          <span class="description">Customers lose interest waiting for replies</span>
        </div>
        <div class="arrow">→</div>
        <div class="after">
          <span class="label">With ContactingAI</span>
          <span class="value">Instant</span>
          <span class="description">Capture interest in real-time</span>
        </div>
      </div>
    </div>

    <div class="benefit-card">
      <h3>Boost Conversion Rates</h3>
      <p>Turn more prospects into customers with immediate, personalized engagement.</p>
      <div class="comparison">
        <div class="before">
          <span class="label">Email</span>
          <span class="value">~5%</span>
          <span class="description">Low engagement rates</span>
        </div>
        <div class="arrow">→</div>
        <div class="after">
          <span class="label">ContactingAI</span>
          <span class="value">15-25%</span>
          <span class="description">Higher conversion rates</span>
        </div>
      </div>
    </div>

    <div class="benefit-card">
      <h3>Scale Your Support</h3>
      <p>Handle more customer interactions without increasing headcount.</p>
      <div class="comparison">
        <div class="before">
          <span class="label">Traditional</span>
          <span class="value">1:1</span>
          <span class="description">Limited by team size</span>
        </div>
        <div class="arrow">→</div>
        <div class="after">
          <span class="label">With AI</span>
          <span class="value">1:100+</span>
          <span class="description">Unlimited scalability</span>
        </div>
      </div>
    </div>
  </section>

  <section class="roi-calculator">
    <h2>Calculate Your ROI</h2>
    <div class="calculator-content">
      <div class="metrics">
        <div class="metric">
          <h4>Current Email Response Time</h4>
          <p class="highlight">24+ Hours</p>
          <p class="improvement">→ Instant with ContactingAI</p>
        </div>
        <div class="metric">
          <h4>Customer Engagement Rate</h4>
          <p class="highlight">3x Higher</p>
          <p class="improvement">with real-time responses</p>
        </div>
        <div class="metric">
          <h4>Support Team Efficiency</h4>
          <p class="highlight">100x</p>
          <p class="improvement">more conversations handled</p>
        </div>
      </div>
    </div>
  </section>

  <section class="testimonials">
    <h2>Success Stories</h2>
    <div class="testimonials-grid">
      <div class="testimonial">
        <div class="quote">"ContactingAI transformed our customer communication. We've seen a 300% increase in conversion rates."</div>
        <div class="author">
          <div class="name">Sarah Johnson</div>
          <div class="title">Head of Sales, TechCorp</div>
        </div>
      </div>
      <div class="testimonial">
        <div class="quote">"Our response times went from hours to seconds. Customer satisfaction is at an all-time high."</div>
        <div class="author">
          <div class="name">Michael Chen</div>
          <div class="title">Customer Success, GrowthCo</div>
        </div>
      </div>
      <div class="testimonial">
        <div class="quote">"The AI-powered responses are incredibly accurate. It's like having a 24/7 support team."</div>
        <div class="author">
          <div class="name">Emma Davis</div>
          <div class="title">CEO, StartupX</div>
        </div>
      </div>
    </div>
  </section>
</div>

<style>
  .benefits-page {
    padding-top: 80px;
    min-height: 100vh;
    background: #f5f7fa;
  }

  .benefits-hero {
    text-align: center;
    padding: 4rem 2rem;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    color: white;
    margin-bottom: 4rem;
  }

  .benefits-hero h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .subtitle {
    font-size: 1.25rem;
    color: #ccc;
    max-width: 600px;
    margin: 0 auto;
  }

  .benefits-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    padding: 0 2rem;
    max-width: 1200px;
    margin: 0 auto 4rem;
  }

  .benefit-card {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .benefit-card h3 {
    color: #1a1a1a;
    font-size: 1.5rem;
    margin-bottom: 1rem;
  }

  .benefit-card p {
    color: #666;
    line-height: 1.6;
    margin-bottom: 1.5rem;
  }

  .comparison {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 1rem;
    background: #f8f9fa;
    border-radius: 0.5rem;
  }

  .before,
  .after {
    flex: 1;
    text-align: center;
  }

  .arrow {
    color: #4a90e2;
    font-size: 1.5rem;
  }

  .label {
    display: block;
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 0.5rem;
  }

  .value {
    display: block;
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
  }

  .before .value {
    color: #666;
  }

  .after .value {
    color: #4a90e2;
  }

  .description {
    display: block;
    font-size: 0.8rem;
    color: #666;
  }

  .roi-calculator {
    padding: 4rem 2rem;
    background: white;
  }

  .roi-calculator h2 {
    text-align: center;
    font-size: 2rem;
    margin-bottom: 2rem;
    color: #1a1a1a;
  }

  .calculator-content {
    max-width: 1200px;
    margin: 0 auto;
  }

  .metrics {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
  }

  .metric {
    text-align: center;
    padding: 2rem;
    background: #f8f9fa;
    border-radius: 1rem;
  }

  .metric h4 {
    color: #1a1a1a;
    margin-bottom: 1rem;
  }

  .highlight {
    font-size: 2rem;
    font-weight: 600;
    color: #4a90e2;
    margin-bottom: 0.5rem;
  }

  .improvement {
    color: #666;
  }

  .testimonials {
    padding: 4rem 2rem;
  }

  .testimonials h2 {
    text-align: center;
    font-size: 2rem;
    margin-bottom: 2rem;
    color: #1a1a1a;
  }

  .testimonials-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }

  .testimonial {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .quote {
    font-size: 1.1rem;
    color: #1a1a1a;
    margin-bottom: 1.5rem;
    line-height: 1.6;
  }

  .author {
    border-top: 1px solid #eee;
    padding-top: 1rem;
  }

  .name {
    font-weight: 600;
    color: #1a1a1a;
  }

  .title {
    color: #666;
    font-size: 0.9rem;
  }
</style>
