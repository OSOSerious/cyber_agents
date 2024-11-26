<script>
  import { Link } from 'svelte-routing';
  import { fade, fly } from 'svelte/transition';
  import { quintOut } from 'svelte/easing';

  let activeTab = 'communication';
  let tabsContainer;

  const features = {
    communication: {
      title: 'Instant Communication',
      description: 'Connect with customers in real-time through their preferred channels.',
      items: [
        {
          title: 'Multi-Channel Support',
          description: 'Engage via chat, voice, or SMS - all from one unified platform.',
          icon: '💬'
        },
        {
          title: 'AI-Powered Responses',
          description: 'Intelligent responses that understand context and customer intent.',
          icon: '🤖'
        },
        {
          title: 'Human Handoff',
          description: 'Seamlessly transition from AI to human agents when needed.',
          icon: '🤝'
        }
      ]
    },
    automation: {
      title: 'Smart Automation',
      description: 'Automate repetitive tasks while maintaining a personal touch.',
      items: [
        {
          title: 'Workflow Automation',
          description: 'Create custom workflows to handle common customer requests.',
          icon: '⚡'
        },
        {
          title: 'Smart Routing',
          description: 'Automatically route inquiries to the right department or agent.',
          icon: '🎯'
        },
        {
          title: 'Scheduled Responses',
          description: 'Schedule follow-ups and reminders for consistent engagement.',
          icon: '📅'
        }
      ]
    },
    analytics: {
      title: 'Powerful Analytics',
      description: 'Gain insights and optimize your customer communication strategy.',
      items: [
        {
          title: 'Performance Metrics',
          description: 'Track response times, satisfaction scores, and conversion rates.',
          icon: '📊'
        },
        {
          title: 'Conversation Analytics',
          description: 'Analyze customer sentiment and common discussion topics.',
          icon: '📈'
        },
        {
          title: 'Custom Reports',
          description: 'Generate detailed reports with the metrics that matter to you.',
          icon: '📋'
        }
      ]
    }
  };

  // Handle keyboard navigation
  function handleKeydown(event) {
    const tabs = Object.keys(features);
    const currentIndex = tabs.indexOf(activeTab);
    
    switch (event.key) {
      case 'ArrowRight':
      case 'ArrowDown':
        event.preventDefault();
        activeTab = tabs[(currentIndex + 1) % tabs.length];
        break;
      case 'ArrowLeft':
      case 'ArrowUp':
        event.preventDefault();
        activeTab = tabs[(currentIndex - 1 + tabs.length) % tabs.length];
        break;
      case 'Home':
        event.preventDefault();
        activeTab = tabs[0];
        break;
      case 'End':
        event.preventDefault();
        activeTab = tabs[tabs.length - 1];
        break;
    }
  }
</script>

<div class="features-page" in:fade>
  <section class="hero-section">
    <div class="hero-content">
      <h1>Features that Drive Results</h1>
      <p class="hero-subtitle">
        Everything you need to transform customer communication from delayed emails to instant interactions.
      </p>
    </div>
  </section>

  <section class="features-tabs" 
    bind:this={tabsContainer}
    role="tablist"
    aria-label="Features categories">
    <div class="tab-buttons">
      {#each Object.entries(features) as [key, value]}
        <button
          role="tab"
          aria-selected={activeTab === key}
          aria-controls="tab-{key}"
          id="tab-button-{key}"
          class:active={activeTab === key}
          on:click={() => activeTab = key}
          on:keydown={handleKeydown}
        >
          {value.title}
        </button>
      {/each}
    </div>

    <div 
      class="tab-content"
      role="tabpanel"
      id="tab-{activeTab}"
      aria-labelledby="tab-button-{activeTab}">
      <div class="feature-header" in:fade>
        <h2>{features[activeTab].title}</h2>
        <p>{features[activeTab].description}</p>
      </div>

      <div class="features-grid">
        {#each features[activeTab].items as feature, i}
          <div 
            class="feature-card"
            in:fly={{
              y: 20,
              duration: 300,
              delay: i * 100,
              easing: quintOut
            }}>
            <div class="feature-icon" aria-hidden="true">{feature.icon}</div>
            <h3>{feature.title}</h3>
            <p>{feature.description}</p>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <section class="demo-section">
    <div class="demo-content">
      <div class="demo-text">
        <h2>See It In Action</h2>
        <p>Watch how ContactingAI can transform your customer communication.</p>
        <div class="demo-features">
          <div class="demo-feature">
            <span class="check-icon">✓</span>
            <span>Real-time customer engagement</span>
          </div>
          <div class="demo-feature">
            <span class="check-icon">✓</span>
            <span>AI and human collaboration</span>
          </div>
          <div class="demo-feature">
            <span class="check-icon">✓</span>
            <span>Multi-channel communication</span>
          </div>
        </div>
        <Link to="/signup" class="cta-button">Start Free Trial</Link>
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
      <h2>Ready to Get Started?</h2>
      <p>Join thousands of businesses that have already transformed their customer communication.</p>
      <div class="cta-buttons">
        <Link to="/signup" class="primary-btn">Start Free Trial</Link>
        <Link to="/pricing" class="secondary-btn">View Pricing</Link>
      </div>
    </div>
  </section>
</div>

<style>
  .features-page {
    background: #f5f7fa;
  }

  .hero-section {
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    color: white;
    padding: 6rem 2rem;
    text-align: center;
  }

  .hero-content {
    max-width: 800px;
    margin: 0 auto;
  }

  h1 {
    font-size: 3rem;
    margin: 0 0 1rem;
  }

  .hero-subtitle {
    font-size: 1.2rem;
    opacity: 0.8;
    margin: 0;
  }

  .features-tabs {
    max-width: 1200px;
    margin: -3rem auto 0;
    padding: 0 2rem;
    position: relative;
  }

  .tab-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    margin-bottom: 3rem;
  }

  .tab-buttons button {
    background: white;
    border: none;
    padding: 1rem 2rem;
    border-radius: 0.5rem;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.2s;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .tab-buttons button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }

  .tab-buttons button.active {
    background: #4a90e2;
    color: white;
  }

  .tab-content {
    background: white;
    border-radius: 1rem;
    padding: 3rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .feature-header {
    text-align: center;
    margin-bottom: 3rem;
  }

  .feature-header h2 {
    font-size: 2rem;
    margin: 0 0 1rem;
  }

  .feature-header p {
    font-size: 1.1rem;
    color: #666;
    margin: 0;
  }

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
  }

  .feature-card {
    background: #f8f9fa;
    padding: 2rem;
    border-radius: 0.5rem;
    transition: transform 0.2s;
  }

  .feature-card:hover {
    transform: translateY(-4px);
  }

  .feature-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
  }

  .feature-card h3 {
    font-size: 1.2rem;
    margin: 0 0 0.5rem;
  }

  .feature-card p {
    color: #666;
    margin: 0;
    line-height: 1.5;
  }

  .demo-section {
    background: white;
    padding: 6rem 2rem;
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
    font-size: 1.25rem;
    margin-bottom: 2rem;
  }

  .demo-features {
    margin-bottom: 2rem;
  }

  .demo-feature {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 1rem;
    color: #666;
  }

  .check-icon {
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
    color: white;
    padding: 6rem 2rem;
    margin-top: 6rem;
    text-align: center;
  }

  .cta-content {
    max-width: 800px;
    margin: 0 auto;
  }

  .cta-content h2 {
    font-size: 2.5rem;
    margin: 0 0 1rem;
  }

  .cta-content p {
    font-size: 1.2rem;
    opacity: 0.8;
    margin: 0 0 2rem;
  }

  .cta-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
  }

  .primary-btn,
  .secondary-btn {
    padding: 1rem 2rem;
    border-radius: 0.5rem;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
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

  @media (max-width: 768px) {
    .tab-buttons {
      flex-direction: column;
    }

    .tab-content {
      padding: 2rem;
    }

    .features-grid {
      grid-template-columns: 1fr;
    }

    h1 {
      font-size: 2.5rem;
    }

    .cta-content h2 {
      font-size: 2rem;
    }

    .cta-buttons {
      flex-direction: column;
    }
  }

  @media (max-width: 480px) {
    .hero-section,
    .cta-section {
      padding: 4rem 1rem;
    }

    .features-tabs {
      padding: 0 1rem;
    }

    h1 {
      font-size: 2rem;
    }
  }
</style>
