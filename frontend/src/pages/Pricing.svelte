<script>
  import { fade } from 'svelte/transition';
  import { Link } from 'svelte-routing';
</script>

<div class="pricing-page" in:fade>
  <section class="pricing-hero">
    <h1>Simple, Transparent Pricing</h1>
    <p class="subtitle">Choose the plan that best fits your business needs</p>
  </section>

  <section class="pricing-grid">
    <div class="pricing-card">
      <div class="pricing-header">
        <h3>Starter</h3>
        <div class="price">
          <span class="amount">$99</span>
          <span class="period">/month</span>
        </div>
        <p class="description">Perfect for small businesses starting with real-time customer communication</p>
      </div>
      <ul class="features-list">
        <li>Up to 1,000 interactions/month</li>
        <li>AI-powered responses</li>
        <li>Chat & SMS channels</li>
        <li>Basic analytics</li>
        <li>Email support</li>
      </ul>
      <Link to="/signup" class="pricing-cta">Start Free Trial</Link>
    </div>
    
    <div class="pricing-card popular">
      <div class="popular-badge">Most Popular</div>
      <div class="pricing-header">
        <h3>Professional</h3>
        <div class="price">
          <span class="amount">$299</span>
          <span class="period">/month</span>
        </div>
        <p class="description">Ideal for growing businesses needing advanced features</p>
      </div>
      <ul class="features-list">
        <li>Unlimited interactions</li>
        <li>AI + Human agent support</li>
        <li>All communication channels</li>
        <li>Advanced analytics</li>
        <li>Custom integrations</li>
        <li>Priority support</li>
      </ul>
      <Link to="/signup" class="pricing-cta">Start Free Trial</Link>
    </div>
    
    <div class="pricing-card">
      <div class="pricing-header">
        <h3>Enterprise</h3>
        <div class="price">
          <span class="amount">Custom</span>
        </div>
        <p class="description">For large organizations requiring custom solutions</p>
      </div>
      <ul class="features-list">
        <li>Unlimited everything</li>
        <li>Dedicated success manager</li>
        <li>Custom AI training</li>
        <li>Priority support</li>
        <li>SLA guarantees</li>
        <li>Custom integrations</li>
      </ul>
      <a href="#contact" class="pricing-cta">Contact Sales</a>
    </div>
  </section>

  <section class="faq">
    <h2>Frequently Asked Questions</h2>
    <div class="faq-grid">
      <div class="faq-item">
        <h3>What's included in the free trial?</h3>
        <p>Our 14-day free trial includes all features from the Professional plan, allowing you to fully experience the power of ContactingAI.</p>
      </div>
      <div class="faq-item">
        <h3>Can I upgrade or downgrade my plan?</h3>
        <p>Yes, you can change your plan at any time. Changes will be reflected in your next billing cycle.</p>
      </div>
      <div class="faq-item">
        <h3>What counts as an interaction?</h3>
        <p>An interaction is any exchange between your business and a customer, whether through AI or human agents.</p>
      </div>
      <div class="faq-item">
        <h3>Do you offer custom solutions?</h3>
        <p>Yes, our Enterprise plan can be customized to meet your specific needs. Contact our sales team to learn more.</p>
      </div>
    </div>
  </section>

  <section class="guarantee">
    <div class="guarantee-content">
      <h2>Our Guarantee</h2>
      <p>Try ContactingAI risk-free with our 14-day money-back guarantee. If you're not completely satisfied, we'll refund your payment.</p>
      <Link to="/signup" class="primary-btn">Start Your Free Trial</Link>
    </div>
  </section>
</div>

<style>
  .pricing-page {
    padding-top: 80px;
    min-height: 100vh;
    background: #f5f7fa;
  }

  .pricing-hero {
    text-align: center;
    padding: 4rem 2rem;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    color: white;
    margin-bottom: 4rem;
  }

  .pricing-hero h1 {
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

  .pricing-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    padding: 0 2rem;
    max-width: 1200px;
    margin: 0 auto 4rem;
  }

  .pricing-card {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    position: relative;
    display: flex;
    flex-direction: column;
  }

  .pricing-card.popular {
    border: 2px solid #4a90e2;
    transform: scale(1.05);
  }

  .popular-badge {
    position: absolute;
    top: -12px;
    left: 50%;
    transform: translateX(-50%);
    background: #4a90e2;
    color: white;
    padding: 0.25rem 1rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    font-weight: 500;
  }

  .pricing-header {
    text-align: center;
    margin-bottom: 2rem;
  }

  .pricing-header h3 {
    color: #1a1a1a;
    font-size: 1.5rem;
    margin-bottom: 1rem;
  }

  .price {
    margin-bottom: 1rem;
  }

  .amount {
    font-size: 2.5rem;
    font-weight: 600;
    color: #1a1a1a;
  }

  .period {
    color: #666;
  }

  .description {
    color: #666;
    font-size: 0.9rem;
  }

  .features-list {
    list-style: none;
    padding: 0;
    margin: 0 0 2rem;
    flex-grow: 1;
  }

  .features-list li {
    padding: 0.5rem 0;
    color: #666;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .features-list li::before {
    content: "✓";
    color: #4a90e2;
    font-weight: bold;
  }

  .pricing-cta {
    display: block;
    text-align: center;
    padding: 1rem;
    background: #4a90e2;
    color: white;
    text-decoration: none;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: background-color 0.2s;
  }

  .pricing-cta:hover {
    background: #357abd;
  }

  .faq {
    padding: 4rem 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }

  .faq h2 {
    text-align: center;
    font-size: 2rem;
    margin-bottom: 2rem;
    color: #1a1a1a;
  }

  .faq-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
    gap: 2rem;
  }

  .faq-item {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .faq-item h3 {
    color: #1a1a1a;
    margin-bottom: 1rem;
  }

  .faq-item p {
    color: #666;
    line-height: 1.6;
  }

  .guarantee {
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    padding: 4rem 2rem;
    text-align: center;
    color: white;
  }

  .guarantee-content {
    max-width: 600px;
    margin: 0 auto;
  }

  .guarantee h2 {
    font-size: 2rem;
    margin-bottom: 1rem;
  }

  .guarantee p {
    color: #ccc;
    margin-bottom: 2rem;
  }

  .primary-btn {
    display: inline-block;
    padding: 1rem 2rem;
    background: #4a90e2;
    color: white;
    text-decoration: none;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: background-color 0.2s;
  }

  .primary-btn:hover {
    background: #357abd;
  }
</style>
