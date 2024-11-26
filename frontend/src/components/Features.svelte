<script>
  import { fade, fly } from 'svelte/transition';
  
  const features = [
    {
      title: "Instant POC",
      description: "AI or human agents connect with customers in real time, responding to interest and intent immediately.",
      icon: "⚡"
    },
    {
      title: "Omni-Channel Strategy",
      description: "Customers are engaged through voice, chat, and SMS — no emails.",
      icon: "🔄"
    },
    {
      title: "Automated Follow-Ups",
      description: "AI or human agents follow up instantly, increasing conversion rates.",
      icon: "🤖"
    },
    {
      title: "Personalized Interactions",
      description: "Every contact is tailored based on customer behavior and preferences.",
      icon: "👤"
    }
  ];
</script>

<section class="features" in:fade>
  <h2>Transformative Platform Features</h2>
  <div class="features-grid">
    {#each features as feature, i}
      <div class="feature-card" in:fly="{{ y: 50, delay: i * 200 }}">
        <div class="icon">{feature.icon}</div>
        <h3>{feature.title}</h3>
        <p>{feature.description}</p>
      </div>
    {/each}
  </div>
</section>

<style>
  .features {
    padding: 4rem 2rem;
    background: #f8f9fa;
  }

  h2 {
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 3rem;
    background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }

  .feature-card {
    background: white;
    padding: 2rem;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
  }

  .feature-card:hover {
    transform: translateY(-5px);
  }

  .icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
  }

  h3 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #1a1a1a;
  }

  p {
    color: #666;
    line-height: 1.6;
  }
</style>
