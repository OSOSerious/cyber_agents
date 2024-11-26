<script>
  import { fade, fly } from 'svelte/transition';
  import { quintOut } from 'svelte/easing';
  import DashboardLayout from '../components/DashboardLayout.svelte';
  import { user } from '../stores/auth';

  // Sample data - replace with actual API calls
  const metrics = {
    conversations: {
      total: 1248,
      trend: '+12.5%',
      positive: true
    },
    responseTime: {
      total: '1.2s',
      trend: '-25%',
      positive: true
    },
    satisfaction: {
      total: '94%',
      trend: '+5%',
      positive: true
    },
    conversion: {
      total: '28%',
      trend: '-2%',
      positive: false
    }
  };

  const recentConversations = [
    {
      id: 1,
      customer: 'John Smith',
      topic: 'Product Inquiry',
      time: '5 min ago',
      status: 'active'
    },
    {
      id: 2,
      customer: 'Sarah Johnson',
      topic: 'Technical Support',
      time: '15 min ago',
      status: 'completed'
    },
    {
      id: 3,
      customer: 'Mike Wilson',
      topic: 'Billing Question',
      time: '1 hour ago',
      status: 'pending'
    }
  ];

  const upcomingTasks = [
    {
      id: 1,
      title: 'Follow up with John',
      time: 'Today, 3:00 PM',
      priority: 'high'
    },
    {
      id: 2,
      title: 'Review support tickets',
      time: 'Tomorrow, 10:00 AM',
      priority: 'medium'
    },
    {
      id: 3,
      title: 'Team meeting',
      time: 'Tomorrow, 2:00 PM',
      priority: 'low'
    }
  ];
</script>

<DashboardLayout>
  <div class="dashboard" in:fade>
    <header class="dashboard-header">
      <div class="welcome-message">
        <h1>Welcome back, {$user?.name || 'User'}! 👋</h1>
        <p>Here's what's happening with your conversations today.</p>
      </div>
    </header>

    <div class="metrics-grid">
      {#each Object.entries(metrics) as [key, value], i}
        <div 
          class="metric-card"
          in:fly={{
            y: 20,
            duration: 300,
            delay: i * 100,
            easing: quintOut
          }}
        >
          <div class="metric-header">
            <h3>{key.replace(/([A-Z])/g, ' $1').toLowerCase()}</h3>
            <span class="trend {value.positive ? 'positive' : 'negative'}">
              {value.trend}
            </span>
          </div>
          <div class="metric-value">{value.total}</div>
        </div>
      {/each}
    </div>

    <div class="dashboard-grid">
      <section class="recent-conversations" in:fly={{ y: 20, duration: 300, delay: 400 }}>
        <h2>Recent Conversations</h2>
        <div class="conversation-list">
          {#each recentConversations as conversation}
            <div class="conversation-card">
              <div class="conversation-info">
                <h3>{conversation.customer}</h3>
                <p>{conversation.topic}</p>
              </div>
              <div class="conversation-meta">
                <span class="time">{conversation.time}</span>
                <span class="status {conversation.status}">{conversation.status}</span>
              </div>
            </div>
          {/each}
        </div>
      </section>

      <section class="upcoming-tasks" in:fly={{ y: 20, duration: 300, delay: 500 }}>
        <h2>Upcoming Tasks</h2>
        <div class="task-list">
          {#each upcomingTasks as task}
            <div class="task-card">
              <div class="task-info">
                <h3>{task.title}</h3>
                <p>{task.time}</p>
              </div>
              <span class="priority {task.priority}">{task.priority}</span>
            </div>
          {/each}
        </div>
      </section>
    </div>
  </div>
</DashboardLayout>

<style>
  .dashboard {
    max-width: 1400px;
    margin: 0 auto;
  }

  .dashboard-header {
    margin-bottom: 2rem;
  }

  h1 {
    font-size: 2rem;
    margin: 0 0 0.5rem;
  }

  .welcome-message p {
    color: #999;
    margin: 0;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
  }

  .metric-card {
    background: #222;
    padding: 1.5rem;
    border-radius: 0.5rem;
    border: 1px solid #333;
  }

  .metric-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .metric-header h3 {
    margin: 0;
    text-transform: capitalize;
    color: #999;
    font-size: 0.9rem;
  }

  .trend {
    font-size: 0.9rem;
    font-weight: 500;
  }

  .trend.positive {
    color: #10b981;
  }

  .trend.negative {
    color: #ef4444;
  }

  .metric-value {
    font-size: 2rem;
    font-weight: 600;
  }

  .dashboard-grid {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 1.5rem;
  }

  .recent-conversations,
  .upcoming-tasks {
    background: #222;
    border-radius: 0.5rem;
    padding: 1.5rem;
    border: 1px solid #333;
  }

  h2 {
    font-size: 1.25rem;
    margin: 0 0 1.5rem;
  }

  .conversation-list,
  .task-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .conversation-card,
  .task-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    background: #2a2a2a;
    border-radius: 0.5rem;
    transition: transform 0.2s;
  }

  .conversation-card:hover,
  .task-card:hover {
    transform: translateY(-2px);
  }

  .conversation-info h3,
  .task-info h3 {
    font-size: 1rem;
    margin: 0 0 0.25rem;
  }

  .conversation-info p,
  .task-info p {
    color: #999;
    font-size: 0.9rem;
    margin: 0;
  }

  .conversation-meta {
    text-align: right;
  }

  .time {
    display: block;
    color: #999;
    font-size: 0.8rem;
    margin-bottom: 0.25rem;
  }

  .status {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    text-transform: capitalize;
  }

  .status.active {
    background: rgba(16, 185, 129, 0.1);
    color: #10b981;
  }

  .status.completed {
    background: rgba(59, 130, 246, 0.1);
    color: #3b82f6;
  }

  .status.pending {
    background: rgba(245, 158, 11, 0.1);
    color: #f59e0b;
  }

  .priority {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    text-transform: capitalize;
  }

  .priority.high {
    background: rgba(239, 68, 68, 0.1);
    color: #ef4444;
  }

  .priority.medium {
    background: rgba(245, 158, 11, 0.1);
    color: #f59e0b;
  }

  .priority.low {
    background: rgba(16, 185, 129, 0.1);
    color: #10b981;
  }

  @media (max-width: 1024px) {
    .dashboard-grid {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 768px) {
    .metrics-grid {
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    }

    .metric-card {
      padding: 1rem;
    }

    .metric-value {
      font-size: 1.5rem;
    }
  }

  @media (max-width: 480px) {
    h1 {
      font-size: 1.5rem;
    }

    .metrics-grid {
      grid-template-columns: 1fr;
    }
  }
</style>
