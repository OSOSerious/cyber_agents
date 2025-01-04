<script>
  import { onMount } from 'svelte';
  import AgentMonitor from '../components/AgentMonitor.svelte';

  export let agentId;
  let agent = null;
  let activeTab = 'overview';
  let isLoading = true;
  let error = null;
  let messageInput = '';
  let messages = [];

  onMount(async () => {
    try {
      // Map of agent IDs to their JSON files
      const agentFiles = {
        'techinsightai': 'tech-analyst-agent.json',
        'narrativeforge': 'creative-writer-agent.json',
        'strategymind': 'business-strategist-agent.json',
        'dr-sarah': 'therapist-character.json',
        'alex': 'social-manager-character.json',
        // Add normalized versions of the IDs
        'techinsight': 'tech-analyst-agent.json',
        'techinsightAI': 'tech-analyst-agent.json',
        'TechInsightAI': 'tech-analyst-agent.json'
      };

      // Normalize the agent ID to handle different cases
      const normalizedId = agentId.toLowerCase().replace(/[^a-z0-9]/g, '');

      const fileName = agentFiles[agentId] || agentFiles[normalizedId];
      if (!fileName) {
        error = `Agent not found: ${agentId}`;
        isLoading = false;
        return;
      }

      const response = await fetch(`/${fileName}`);
      if (!response.ok) throw new Error(`Failed to load agent data`);
      const data = await response.json();

      agent = {
        ...data,
        id: agentId,
        status: data.deployment?.autoStart ? 'active' : 'inactive',
        deployedTo: data.clients || [],
        lastActive: new Date().toISOString()
      };

      // Simulated chat history
      messages = [
        {
          type: 'user',
          content: 'What are the latest trends in AI technology?',
          timestamp: new Date(Date.now() - 120000)
        },
        {
          type: 'agent',
          content: `Based on recent developments, here are the key AI trends:
1. Multimodal AI models combining text, vision, and speech
2. Advances in AI agents and autonomous systems
3. Improved efficiency in large language models
4. Focus on AI safety and alignment`,
          timestamp: new Date(Date.now() - 60000)
        }
      ];

      isLoading = false;
    } catch (err) {
      console.error('Failed to load agent:', err);
      error = err.message;
      isLoading = false;
    }
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

  function formatMessageTime(timestamp) {
    return new Intl.DateTimeFormat('en-US', {
      hour: 'numeric',
      minute: 'numeric',
      hour12: true
    }).format(timestamp);
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

  async function sendMessage() {
    if (!messageInput.trim()) return;

    const userMessage = {
      type: 'user',
      content: messageInput,
      timestamp: new Date()
    };
    messages = [...messages, userMessage];
    messageInput = '';

    // Simulate agent response
    setTimeout(() => {
      const agentMessage = {
        type: 'agent',
        content: `Thank you for your message. As an AI analyst, I'll process your request: "${userMessage.content}"`,
        timestamp: new Date()
      };
      messages = [...messages, agentMessage];
    }, 1000);
  }

  function handleKeyPress(event) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      sendMessage();
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
            class="py-4 px-1 border-b-2 font-medium text-sm {activeTab === 'chat' ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
            on:click={() => activeTab = 'chat'}
          >
            Chat
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
        <!-- Bio & Expertise -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Bio & Expertise</h2>
          {#if agent.bio}
            <div class="mb-6">
              <h3 class="text-sm font-medium text-gray-700 mb-2">Background</h3>
              <ul class="list-disc pl-4 space-y-2">
                {#each agent.bio as item}
                  <li class="text-sm text-gray-600">{item}</li>
                {/each}
              </ul>
            </div>
          {/if}

          {#if agent.knowledge}
            <div class="mb-6">
              <h3 class="text-sm font-medium text-gray-700 mb-2">Knowledge Areas</h3>
              <ul class="list-disc pl-4 space-y-2">
                {#each agent.knowledge as item}
                  <li class="text-sm text-gray-600">{item}</li>
                {/each}
              </ul>
            </div>
          {/if}

          {#if agent.topics}
            <div>
              <h3 class="text-sm font-medium text-gray-700 mb-2">Specialization Topics</h3>
              <div class="flex flex-wrap gap-2">
                {#each agent.topics as topic}
                  <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                    {topic}
                  </span>
                {/each}
              </div>
            </div>
          {/if}
        </div>

        <!-- Capabilities -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Capabilities</h2>
          {#if agent.capabilities}
            {#each Object.entries(agent.capabilities) as [category, items]}
              <div class="mb-6 last:mb-0">
                <h3 class="text-sm font-medium text-gray-700 mb-2 capitalize">{category}</h3>
                <ul class="list-disc pl-4 space-y-2">
                  {#each items as item}
                    <li class="text-sm text-gray-600">{item}</li>
                  {/each}
                </ul>
              </div>
            {/each}
          {/if}
        </div>

        <!-- Communication Style -->
        <div class="bg-white rounded-lg shadow-md p-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-4">Communication Style</h2>
          {#if agent.style}
            {#each Object.entries(agent.style) as [context, guidelines]}
              <div class="mb-6 last:mb-0">
                <h3 class="text-sm font-medium text-gray-700 mb-2 capitalize">{context} Communication</h3>
                <ul class="list-disc pl-4 space-y-2">
                  {#each guidelines as guideline}
                    <li class="text-sm text-gray-600">{guideline}</li>
                  {/each}
                </ul>
              </div>
            {/each}
          {/if}
        </div>
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

        {#if agent.characterStats}
          <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-900 mb-4">Character Profile</h2>
            <div class="space-y-6">
              <div class="grid grid-cols-2 gap-4">
                {#each Object.entries(agent.characterStats) as [stat, value]}
                  {#if typeof value === 'number'}
                    <div>
                      <div class="flex justify-between items-center mb-1">
                        <span class="text-sm font-medium text-gray-700 capitalize">{stat}</span>
                        <span class="text-sm text-gray-600">{value}/10</span>
                      </div>
                      <div class="w-full bg-gray-200 rounded-full h-2">
                        <div 
                          class="h-2 rounded-full" 
                          class:bg-indigo-600={stat === 'wisdom'}
                          class:bg-blue-500={stat === 'patience'}
                          class:bg-red-500={stat === 'strength'}
                          class:bg-green-500={stat === 'health'}
                          style="width: {value * 10}%"
                        ></div>
                      </div>
                    </div>
                  {/if}
                {/each}
              </div>
              {#if agent.characterStats.routine}
                <div>
                  <h3 class="text-lg font-medium text-gray-900 mb-2">Daily Routine</h3>
                  <ul class="space-y-2">
                    {#each agent.characterStats.routine as item}
                      <li class="flex items-start">
                        <span class="text-indigo-500 mr-2">•</span>
                        <span class="text-gray-600">{item}</span>
                      </li>
                    {/each}
                  </ul>
                </div>
              {/if}
            </div>
          </div>
        {/if}
      </div>
    {:else if activeTab === 'chat'}
      <div class="bg-white rounded-lg shadow-md">
        <div class="chat-interface h-[600px] flex flex-col">
          <div class="flex-1 overflow-y-auto p-6">
            <div class="space-y-4">
              {#each messages as message}
                <div class="message {message.type === 'user' ? 'flex justify-end' : 'flex justify-start'}">
                  <div class="max-w-[80%] {message.type === 'user' ? 'bg-indigo-100 text-indigo-900' : 'bg-gray-100 text-gray-900'} rounded-lg p-4">
                    <div class="whitespace-pre-wrap">{message.content}</div>
                    <div class="text-xs text-gray-500 mt-1">
                      {formatMessageTime(message.timestamp)}
                    </div>
                  </div>
                </div>
              {/each}
            </div>
          </div>
          <div class="border-t p-4">
            <div class="flex gap-4">
              <textarea
                bind:value={messageInput}
                on:keypress={handleKeyPress}
                placeholder="Type your message..."
                class="flex-1 resize-none border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                rows="3"
              ></textarea>
              <button
                on:click={sendMessage}
                class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition-colors self-end"
              >
                Send
              </button>
            </div>
          </div>
        </div>
      </div>
    {:else if activeTab === 'monitoring'}
      <AgentMonitor {agentId} />
    {:else if activeTab === 'settings'}
      <div class="bg-white rounded-lg shadow-md p-6">
        <h2 class="text-lg font-semibold text-gray-900 mb-4">Agent Settings</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="space-y-6">
            <div>
              <h3 class="text-base font-medium text-gray-900 mb-4">Basic Settings</h3>
              <div class="space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700">Agent Name</label>
                  <input
                    type="text"
                    value={agent.name}
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                  />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Description</label>
                  <textarea
                    rows="3"
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                  >{agent.description}</textarea>
                </div>
              </div>
            </div>

            <div>
              <h3 class="text-base font-medium text-gray-900 mb-4">Schedule</h3>
              <div class="space-y-4">
                <label class="flex items-center">
                  <input
                    type="checkbox"
                    checked={agent.deployment.schedule.active}
                    class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                  />
                  <span class="ml-2 text-sm text-gray-900">Enable scheduled availability</span>
                </label>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Timezone</label>
                  <select class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500">
                    <option value="UTC">UTC</option>
                    <option value="America/New_York">Eastern Time</option>
                    <option value="America/Chicago">Central Time</option>
                    <option value="America/Denver">Mountain Time</option>
                    <option value="America/Los_Angeles">Pacific Time</option>
                  </select>
                </div>
                <div class="space-y-2">
                  <label class="block text-sm font-medium text-gray-700">Available Days</label>
                  <div class="grid grid-cols-4 gap-2">
                    {#each ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'] as day}
                      <label class="inline-flex items-center">
                        <input
                          type="checkbox"
                          checked={agent.deployment.schedule.availability[0].days.includes(day.toLowerCase())}
                          class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                        />
                        <span class="ml-2 text-sm text-gray-900">{day}</span>
                      </label>
                    {/each}
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="space-y-6">
            <div>
              <h3 class="text-base font-medium text-gray-900 mb-4">Platform Integration</h3>
              <div class="space-y-4">
                {#each ['Discord', 'Telegram', 'Direct API'] as platform}
                  <label class="flex items-center justify-between p-4 border rounded-lg">
                    <div class="flex items-center">
                      <input
                        type="checkbox"
                        checked={agent.deployedTo.includes(platform.toLowerCase())}
                        class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                      />
                      <span class="ml-2 text-sm text-gray-900">{platform}</span>
                    </div>
                    <button class="text-sm text-indigo-600 hover:text-indigo-900">Configure</button>
                  </label>
                {/each}
              </div>
            </div>

            <div>
              <h3 class="text-base font-medium text-gray-900 mb-4">Performance Settings</h3>
              <div class="space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700">Response Time Threshold (seconds)</label>
                  <input
                    type="number"
                    value="2"
                    min="0"
                    step="0.1"
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                  />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Accuracy Threshold (%)</label>
                  <input
                    type="number"
                    value="90"
                    min="0"
                    max="100"
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                  />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Memory Retention (days)</label>
                  <input
                    type="number"
                    value="30"
                    min="1"
                    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="mt-6 flex justify-end gap-3">
          <button class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            Cancel
          </button>
          <button class="px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            Save Changes
          </button>
        </div>
      </div>
    {/if}
  {/if}
</div>

<style>
  .chat-interface {
    height: 600px;
  }

  .message {
    animation: fadeIn 0.3s ease-out;
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>
