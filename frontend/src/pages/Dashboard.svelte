<script>
  import { onMount } from 'svelte';
  import { api } from '../services/api';
  import DashboardLayout from '../components/DashboardLayout.svelte';

  let analytics = null;
  let channelMetrics = null;
  let aiAnalysis = null;
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      [analytics, channelMetrics, aiAnalysis] = await Promise.all([
        api.getAnalytics(),
        api.getChannelMetrics(),
        api.getAIAnalysis()
      ]);
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  });
</script>

<DashboardLayout>
  <div class="dashboard">
    <header>
      <h1>AI Communication Hub</h1>
      <button class="new-interaction">Start New Interaction</button>
    </header>

    {#if loading}
      <div class="loading">Loading analytics...</div>
    {:else if error}
      <div class="error">{error}</div>
    {:else}
      <!-- Real-time Metrics -->
      <section class="metrics-grid">
        <div class="metric-card highlight">
          <h3>Active Conversations</h3>
          <div class="metric-content">
            <div class="metric-main">
              <span class="value">{analytics.active_conversations}</span>
              <span class="label">Live Now</span>
            </div>
            <div class="metric-breakdown">
              <div class="breakdown-item">
                <span class="label">AI Handled</span>
                <span class="value">{analytics.ai_handled}</span>
              </div>
              <div class="breakdown-item">
                <span class="label">Human Assisted</span>
                <span class="value">{analytics.human_assisted}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="metric-card">
          <h3>Interaction Channels</h3>
          <div class="channels-grid">
            <div class="channel-item">
              <span class="channel-icon">💬</span>
              <span class="channel-name">Web Chat</span>
              <span class="channel-value">{channelMetrics.web_chat}</span>
            </div>
            <div class="channel-item">
              <span class="channel-icon">📱</span>
              <span class="channel-name">SMS/iMessage</span>
              <span class="channel-value">{channelMetrics.messaging}</span>
            </div>
            <div class="channel-item">
              <span class="channel-icon">📞</span>
              <span class="channel-name">Voice Call</span>
              <span class="channel-value">{channelMetrics.voice}</span>
            </div>
            <div class="channel-item">
              <span class="channel-icon">🤳</span>
              <span class="channel-name">Video Chat</span>
              <span class="channel-value">{channelMetrics.video}</span>
            </div>
          </div>
        </div>

        <div class="metric-card">
          <h3>AI Analysis</h3>
          <div class="ai-metrics">
            <div class="ai-metric">
              <span class="label">Intent Recognition</span>
              <div class="progress-bar">
                <div class="progress" style="width: {aiAnalysis.intent_recognition}%"></div>
              </div>
              <span class="value">{aiAnalysis.intent_recognition}%</span>
            </div>
            <div class="ai-metric">
              <span class="label">Sentiment Score</span>
              <div class="progress-bar">
                <div class="progress" style="width: {aiAnalysis.sentiment_score}%"></div>
              </div>
              <span class="value">{aiAnalysis.sentiment_score}%</span>
            </div>
            <div class="ai-metric">
              <span class="label">Resolution Rate</span>
              <div class="progress-bar">
                <div class="progress" style="width: {aiAnalysis.resolution_rate}%"></div>
              </div>
              <span class="value">{aiAnalysis.resolution_rate}%</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Interaction Flow -->
      <section class="interaction-flow">
        <h2>Interaction Flow</h2>
        <div class="flow-cards">
          <div class="flow-card">
            <div class="flow-icon">🌐</div>
            <h4>Source Channels</h4>
            <ul>
              <li>Website Traffic</li>
              <li>Social Media</li>
              <li>Direct Calls</li>
              <li>Ad Response</li>
            </ul>
          </div>
          <div class="flow-arrow">➜</div>
          <div class="flow-card">
            <div class="flow-icon">🤖</div>
            <h4>AI Analysis</h4>
            <ul>
              <li>Intent Detection</li>
              <li>Sentiment Analysis</li>
              <li>Priority Scoring</li>
              <li>Channel Selection</li>
            </ul>
          </div>
          <div class="flow-arrow">➜</div>
          <div class="flow-card">
            <div class="flow-icon">🎯</div>
            <h4>Engagement</h4>
            <ul>
              <li>AI Chat Support</li>
              <li>Human Agent</li>
              <li>Video Consultation</li>
              <li>Voice Assistant</li>
            </ul>
          </div>
        </div>
      </section>
    {/if}
  </div>
</DashboardLayout>

<style>
  .dashboard {
    padding: 2em;
    max-width: 1400px;
    margin: 0 auto;
  }

  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2em;
  }

  h1 {
    font-size: 2em;
    color: #2d3748;
    margin: 0;
  }

  .new-interaction {
    background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
    color: white;
    border: none;
    padding: 0.8em 1.5em;
    border-radius: 25px;
    font-weight: 500;
    cursor: pointer;
    transition: transform 0.2s;
    box-shadow: 0 4px 6px rgba(99, 102, 241, 0.2);
  }

  .new-interaction:hover {
    transform: translateY(-2px);
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5em;
    margin-bottom: 2em;
  }

  .metric-card {
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 1.5em;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .metric-card.highlight {
    background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
    color: white;
  }

  .metric-card h3 {
    margin: 0 0 1em;
    font-size: 1.1em;
    color: inherit;
  }

  .channels-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1em;
  }

  .channel-item {
    display: flex;
    align-items: center;
    gap: 0.5em;
    padding: 0.8em;
    background: rgba(0, 0, 0, 0.03);
    border-radius: 10px;
  }

  .channel-icon {
    font-size: 1.2em;
  }

  .channel-name {
    flex: 1;
    font-size: 0.9em;
  }

  .channel-value {
    font-weight: 600;
  }

  .ai-metrics {
    display: grid;
    gap: 1em;
  }

  .ai-metric {
    display: grid;
    grid-template-columns: 1fr 100px 50px;
    align-items: center;
    gap: 1em;
  }

  .progress-bar {
    width: 100%;
    height: 8px;
    background: rgba(0, 0, 0, 0.05);
    border-radius: 4px;
    overflow: hidden;
  }

  .progress {
    height: 100%;
    background: linear-gradient(90deg, #6366f1 0%, #4f46e5 100%);
    border-radius: 4px;
  }

  .interaction-flow {
    margin-top: 2em;
  }

  .interaction-flow h2 {
    font-size: 1.5em;
    margin-bottom: 1em;
    color: #2d3748;
  }

  .flow-cards {
    display: flex;
    align-items: center;
    gap: 1em;
    overflow-x: auto;
    padding: 1em 0;
  }

  .flow-card {
    background: white;
    border-radius: 15px;
    padding: 1.5em;
    min-width: 250px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .flow-icon {
    font-size: 2em;
    margin-bottom: 0.5em;
  }

  .flow-card h4 {
    margin: 0 0 1em;
    color: #2d3748;
  }

  .flow-card ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .flow-card li {
    padding: 0.5em 0;
    color: #4a5568;
    border-bottom: 1px solid #edf2f7;
  }

  .flow-card li:last-child {
    border-bottom: none;
  }

  .flow-arrow {
    font-size: 1.5em;
    color: #4a5568;
  }

  @media (max-width: 768px) {
    .dashboard {
      padding: 1em;
    }

    header {
      flex-direction: column;
      gap: 1em;
      text-align: center;
    }

    .flow-cards {
      flex-direction: column;
    }

    .flow-arrow {
      transform: rotate(90deg);
    }
  }
</style>
