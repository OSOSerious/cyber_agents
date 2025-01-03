<script>
  import { onMount } from 'svelte';
  import AgentMonitor from '../components/AgentMonitor.svelte';

  export let agentId;
  let agent = null;
  let activeTab = 'overview';
  let isLoading = true;
  let error = null;

  onMount(async () => {
    // Simulated data - would be replaced with actual API call
    agent = {
      id: agentId,
      name: 'TechInsightAI',
      type: 'Tech Analyst',
      status: 'active',
      deployedTo: ['discord', 'direct'],
      lastActive: '2024-03-20T15:30:00Z',
      description: 'AI analyst specializing in emerging technologies and market trends',
      metrics: {
        interactions: 156,
        responseTime: 1.2,
        accuracy: 94
      },
      deployment: {
        environment: 'production',
        autoStart: true,
        schedule: {
          active: true,
          timezone: 'UTC',
          availability: [
            {
              days: ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
              hours: ['09:00-17:00']
            }
          ]
        }
      }
    };
    isLoading = false;
  });

  function getStatusColor(status) {
    switch (status) {
      case 'active': return 'bg-green-500';
      case 'warning': return 'bg-yellow-500';
      case 'inactive': return 'bg-red-500';
      default: return 'bg-gray-500';
    }
  }

  function formatLastActive(dateString) {
    return new Date(dateString).toLocaleString();
  }

  async function handleAction(action) {
    switch (action) {
      case 'start':
        // API call to start agent
        agent.status = 'active';
        break;
      case 'stop':
        // API call to stop agent
        agent.status = 'inactive';
        break;
      case 'restart':
        // API call to restart agent
        agent.status = 'active';
        break;
    }
  }
</script>

<div class="container mx-auto p-6">
  {#if isLoading}
    <div class="flex justify-center items-center h-64">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
    </div>
  {:else if error}
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
      <strong class="font-bold">Error!</strong>
      <span class="block sm:inline">{error}</span>
    </div>
  {:else}
    <div class="bg-white rounded-lg shadow-md p-6 mb-8">
      <div class="flex justify-between items-start">
        <div>
          <div class="flex items-center gap-3 mb-2">
            <h1 class="text-2xl font-bold text-gray-900">{agent.name}</h1>
            <span class={`inline-block w-3 h-3 rounded-full ${getStatusColor(agent.status)}`}></span>
            <span class="text-sm text-gray-500">{agent.status}</span>
          </div>
          <p class="text-gray-600 mb-4">{agent.description}</p>
          <div class="text-sm text-gray-500">
            Last active: {formatLastActive(agent.lastActive)}
          </div>
        </div>
        <div class="flex gap-2">
          {#if agent.status === 'active'}
            <button 
              class="bg-red-100 text-red-600 px-4 py-2 rounded-md hover:bg-red-200 transition-colors"
              on:click={() => handleAction('stop')}
            >
              Stop Agent
            </button>
            <button 
              class="bg-indigo-100 text-indigo-600 px-4 py-2 rounded-md hover:bg-indigo-200 transition-colors"
              on:click={() => handleAction('restart')}
            >
              Restart
            </button>
          {:else}
            <button 
              class="bg-green-100 text-green-600 px-4 py-2 rounded-md hover:bg-green-200 transition-colors"
              on:click={() => handleAction('start')}
            >
              Start Agent
            </button>
          {/if}
        </div>
      </div>
    </div>

    <div class="mb-8">
      <div class="border-b border-gray-200">
        <nav class="flex space-x-8">
          <button
            class="py-4 px-1 border-b-2 font-medium text-sm {activeTab === 'overview' ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
            on:click={() => activeTab = 'overview'}
          >
            Overview
          </button>
          <button
            class="py-4 px-1 border-b-2 font-medium text-sm {activeTab === 'monitoring' ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
            on:click={() => activeTab = 'monitoring'}
          >
            Monitoring
          </button>
          <button
            class="py-4 px-1 border-b-2 font-medium text-sm {activeTab === 'settings' ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
            on:click={() => activeTab = 'settings'}
          >
            Settings
          </button>
        </nav>
      </div>
    </div>

    {#if activeTab === 'overview'}
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Deployment Info</h2>
          <div class="space-y-4">
            <div>
              <span class="text-sm font-medium text-gray-500">Environment</span>
              <p class="mt-1 text-gray-900">{agent.deployment.environment}</p>
            </div>
            <div>
              <span class="text-sm font-medium text-gray-500">Auto-start</span>
              <p class="mt-1 text-gray-900">{agent.deployment.autoStart ? 'Enabled' : 'Disabled'}</p>
            </div>
            <div>
              <span class="text-sm font-medium text-gray-500">Schedule</span>
              <p class="mt-1 text-gray-900">
                {agent.deployment.schedule.active ? 'Active' : 'Inactive'}
                {#if agent.deployment.schedule.active}
                  <br>
                  {agent.deployment.schedule.availability[0].days.join(', ')}
                  <br>
                  {agent.deployment.schedule.availability[0].hours[0]}
                {/if}
              </p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Performance</h2>
          <div class="space-y-4">
            <div>
              <span class="text-sm font-medium text-gray-500">Total Interactions</span>
              <p class="mt-1 text-2xl font-semibold text-gray-900">{agent.metrics.interactions}</p>
            </div>
            <div>
              <span class="text-sm font-medium text-gray-500">Response Time</span>
              <p class="mt-1 text-2xl font-semibold text-gray-900">{agent.metrics.responseTime}s</p>
            </div>
            <div>
              <span class="text-sm font-medium text-gray-500">Accuracy</span>
              <p class="mt-1 text-2xl font-semibold text-gray-900">{agent.metrics.accuracy}%</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Platform Integration</h2>
          <div class="space-y-4">
            {#each agent.deployedTo as platform}
              <div class="flex items-center justify-between">
                <span class="text-gray-900">{platform}</span>
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                  Connected
                </span>
              </div>
            {/each}
          </div>
        </div>
      </div>
    {:else if activeTab === 'monitoring'}
      <AgentMonitor {agentId} />
    {:else if activeTab === 'settings'}
      <div class="bg-white rounded-lg shadow-md p-6">
        <h2 class="text-lg font-semibold text-gray-900 mb-4">Agent Settings</h2>
        <!-- Settings form would go here -->
        <p class="text-gray-500">Settings configuration coming soon...</p>
      </div>
    {/if}
  {/if}
</div>

<style>
  /* Add any additional styles here */
</style>
