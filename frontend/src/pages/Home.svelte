<script>
  import { Link } from "svelte-routing";
</script>

<div class="home">
  <div class="hero">
    <div class="hero-content">
      <h1>Build Powerful AI Agents</h1>
      <p>Create, deploy, and manage autonomous AI agents with advanced capabilities and multi-platform support</p>
      <div class="cta-buttons">
        <Link to="/character-builder" class="cta-button primary">Create Agent</Link>
        <Link to="/templates" class="cta-button secondary">Browse Templates</Link>
      </div>
    </div>
  </div>

  <section class="features">
    <h2>Core Features</h2>
    <div class="feature-grid">
      <div class="feature-card">
        <div class="feature-icon">🤖</div>
        <h3>Multi-Model Support</h3>
        <p>Use any AI model: Llama, Grok, OpenAI, Anthropic, and more</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🔗</div>
        <h3>Platform Integration</h3>
        <p>Full-featured Discord, Twitter, and Telegram connectors</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">👥</div>
        <h3>Multi-Agent System</h3>
        <p>Create agent teams with shared contexts and collaborative capabilities</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">💾</div>
        <h3>Memory Management</h3>
        <p>Advanced retrievable memory and document store system</p>
      </div>
    </div>
  </section>

  <section class="capabilities">
    <h2>Advanced Capabilities</h2>
    <div class="capability-grid">
      <div class="capability-card">
        <span class="capability-icon">📚</span>
        <h3>Document Processing</h3>
        <p>Easily ingest and interact with documents, PDFs, and knowledge bases</p>
      </div>
      <div class="capability-card">
        <span class="capability-icon">🔄</span>
        <h3>Extensible System</h3>
        <p>Create custom actions and clients to extend agent capabilities</p>
      </div>
      <div class="capability-card">
        <span class="capability-icon">🎮</span>
        <h3>Interactive Agents</h3>
        <p>Build chatbots, game characters, and autonomous business agents</p>
      </div>
      <div class="capability-card">
        <span class="capability-icon">🚀</span>
        <h3>Easy Deployment</h3>
        <p>Simple setup and deployment across multiple platforms</p>
      </div>
    </div>
  </section>

  <section class="use-cases">
    <h2>Use Cases</h2>
    <div class="use-case-grid">
      <div class="use-case-card">
        <span class="use-case-icon">🤖</span>
        <h3>Chatbots</h3>
        <p>Create engaging conversational agents for customer support and interaction</p>
      </div>
      <div class="use-case-card">
        <span class="use-case-icon">🕵️</span>
        <h3>Autonomous Agents</h3>
        <p>Build self-directed agents that can accomplish complex tasks</p>
      </div>
      <div class="use-case-card">
        <span class="use-case-icon">📈</span>
        <h3>Business Process</h3>
        <p>Automate and enhance business workflows with intelligent agents</p>
      </div>
      <div class="use-case-card">
        <span class="use-case-icon">🎮</span>
        <h3>Gaming & Entertainment</h3>
        <p>Create interactive NPCs and game characters with personality</p>
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

  .feature-grid,
  .capability-grid,
  .use-case-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2em;
    max-width: 1200px;
    margin: 0 auto;
  }

  .feature-card,
  .capability-card,
  .use-case-card {
    background: white;
    padding: 2em;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s;
  }

  .feature-card:hover,
  .capability-card:hover,
  .use-case-card:hover {
    transform: translateY(-5px);
  }

  .feature-icon,
  .capability-icon,
  .use-case-icon {
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

  .capabilities {
    background: #f7fafc;
  }

  .use-cases {
    background: #edf2f7;
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
