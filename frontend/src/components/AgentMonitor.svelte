<script>
  import { onMount } from 'svelte';

  export let agentId;
  let logs = [];
  let metrics = {
    last24h: {
      interactions: 0,
      avgResponseTime: 0,
      accuracy: 0,
      errors: 0
    },
    lastWeek: {
      interactions: 0,
      avgResponseTime: 0,
      accuracy: 0,
      errors: 0
    }
  };
  let selectedTimeframe = 'last24h';
  let isLoading = true;
  let error = null;
  let logFilters = {
    level: 'all',
    platform: 'all'
  };

  onMount(async () => {
    // Simulated data - would be replaced with actual API calls
    logs = [
      {
        timestamp: '2024-03-20T15:30:00Z',
        level: 'info',
        platform: 'discord',
        message: 'Successfully processed user query about emerging AI trends',
        metadata: {
          responseTime: 1.2,
          accuracy: 0.94,
          userId: 'user123'
        }
      },
      {
        timestamp: '2024-03-20T15:25:00Z',
        level: 'warning',
        platform: 'twitter',
        message: 'Rate limit approaching for Twitter API',
        metadata: {
          remainingCalls: 50,
          resetTime: '2024-03-20T16:00:00Z'
        }
      },
      {
        timestamp: '2024-03-20T15:20:00Z',
        level: 'error',
        platform: 'discord',
        message: 'Failed to process image analysis request',
        metadata: {
          error: 'Invalid image format',
          requestId: 'req456'
        }
      }
    ];

    metrics = {
      last24h: {
        interactions: 156,
        avgResponseTime: 1.2,
        accuracy: 0.94,
        errors: 3
      },
      lastWeek: {
        interactions: 892,
        avgResponseTime: 1.4,
        accuracy: 0.92,
        errors: 12
      }
    };

    isLoading = false;
  });

  function getLogLevelColor(level) {
    switch (level) {
      case 'info': return 'bg-blue-100 text-blue-800';
      case 'warning': return 'bg-yellow-100 text-yellow-800';
      case 'error': return 'bg-red-100 text-red-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  }

  function formatTimestamp(timestamp) {
    return new Date(timestamp).toLocaleString();
  }

  function formatMetricValue(value, type) {
    switch (type) {
      case 'accuracy':
        return `${(value * 100).toFixed(1)}%`;
      case 'avgResponseTime':
        return `${value.toFixed(2)}s`;
      default:
        return value.toString();
    }
  }

  $: filteredLogs = logs.filter(log => {
    if (logFilters.level !== 'all' && log.level !== logFilters.level) return false;
    if (logFilters.platform !== 'all' && log.platform !== logFilters.platform) return false;
    return true;
  });
</script>

<div class="container mx-auto p-6">
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
    <div class="stat-card">
      <h3>Interactions</h3>
      <div class="stat-value">{metrics[selectedTimeframe].interactions}</div>
      <div class="stat-desc">Total interactions</div>
    </div>
    <div class="stat-card">
      <h3>Response Time</h3>
      <div class="stat-value">{formatMetricValue(metrics[selectedTimeframe].avgResponseTime, 'avgResponseTime')}</div>
      <div class="stat-desc">Average response time</div>
    </div>
    <div class="stat-card">
      <h3>Accuracy</h3>
      <div class="stat-value">{formatMetricValue(metrics[selectedTimeframe].accuracy, 'accuracy')}</div>
      <div class="stat-desc">Response accuracy</div>
    </div>
    <div class="stat-card">
      <h3>Errors</h3>
      <div class="stat-value">{metrics[selectedTimeframe].errors}</div>
      <div class="stat-desc">Total errors</div>
    </div>
  </div>

  <div class="bg-white rounded-lg shadow-md p-6 mb-8">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-xl font-bold text-gray-900">Performance Metrics</h2>
      <div class="flex gap-2">
        <button 
          class="px-3 py-1 rounded-md {selectedTimeframe === 'last24h' ? 'bg-indigo-600 text-white' : 'bg-gray-100 text-gray-600'}"
          on:click={() => selectedTimeframe = 'last24h'}
        >
          Last 24h
        </button>
        <button 
          class="px-3 py-1 rounded-md {selectedTimeframe === 'lastWeek' ? 'bg-indigo-600 text-white' : 'bg-gray-100 text-gray-600'}"
          on:click={() => selectedTimeframe = 'lastWeek'}
        >
          Last Week
        </button>
      </div>
    </div>

    <div class="grid grid-cols-2 gap-4">
      <div class="metric-chart">
        <!-- Placeholder for response time chart -->
        <div class="h-48 bg-gray-50 rounded-lg flex items-center justify-center">
          Response Time Chart
        </div>
      </div>
      <div class="metric-chart">
        <!-- Placeholder for accuracy chart -->
        <div class="h-48 bg-gray-50 rounded-lg flex items-center justify-center">
          Accuracy Chart
        </div>
      </div>
    </div>
  </div>

  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-xl font-bold text-gray-900">Activity Logs</h2>
      <div class="flex gap-4">
        <select 
          class="px-3 py-1 border rounded-md"
          bind:value={logFilters.level}
        >
          <option value="all">All Levels</option>
          <option value="info">Info</option>
          <option value="warning">Warning</option>
          <option value="error">Error</option>
        </select>
        <select 
          class="px-3 py-1 border rounded-md"
          bind:value={logFilters.platform}
        >
          <option value="all">All Platforms</option>
          <option value="discord">Discord</option>
          <option value="twitter">Twitter</option>
          <option value="direct">Direct</option>
        </select>
      </div>
    </div>

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
      <div class="space-y-4">
        {#each filteredLogs as log}
          <div class="border rounded-lg p-4">
            <div class="flex justify-between items-start mb-2">
              <div class="flex items-center gap-2">
                <span class={`px-2 py-1 rounded-md text-sm font-medium ${getLogLevelColor(log.level)}`}>
                  {log.level}
                </span>
                <span class="text-sm text-gray-500">{formatTimestamp(log.timestamp)}</span>
              </div>
              <span class="text-sm font-medium text-gray-600">{log.platform}</span>
            </div>
            <p class="text-gray-700 mb-2">{log.message}</p>
            {#if log.metadata}
              <div class="bg-gray-50 rounded p-2 text-sm text-gray-600">
                <pre class="whitespace-pre-wrap">{JSON.stringify(log.metadata, null, 2)}</pre>
              </div>
            {/if}
          </div>
        {/each}
      </div>
    {/if}
  </div>
</div>

<style>
  .stat-card {
    @apply bg-white p-6 rounded-lg shadow-md;
  }

  .stat-card h3 {
    @apply text-sm text-gray-500 mb-1;
  }

  .stat-value {
    @apply text-3xl font-bold text-gray-900;
  }

  .stat-desc {
    @apply text-sm text-gray-500 mt-1;
  }

  pre {
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', 'Consolas', monospace;
  }
</style>
