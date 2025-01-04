<script>
  import { Link, navigate } from "svelte-routing";
  import { fade } from 'svelte/transition';
  import { onMount } from 'svelte';

  let agents = [];
  let isLoading = true;
  let error = null;

  onMount(async () => {
    try {
      // Simulated agent data that matches the profile structure
      agents = [
        {
          id: 'techinsightai',
          name: "Tech Insight AI",
          type: "Technology Analyst",
          status: "active",
          platform: "All Platforms",
          lastActive: "2 mins ago",
          description: "Advanced AI analyst specializing in technology trends and insights",
          modelProvider: "GPT-4",
          version: "1.0",
          deployment: {
            autoStart: true,
            environment: "production"
          },
          memory: {
            conversations: 156,
            facts: 42
          }
        },
        {
          id: 'narrativeforge',
          name: "Narrative Forge",
          type: "Creative Writer",
          status: "active",
          platform: "Web",
          lastActive: "5 mins ago",
          description: "AI-powered creative writing assistant for content creation",
          modelProvider: "GPT-4",
          version: "1.0",
          deployment: {
            autoStart: true,
            environment: "production"
          },
          memory: {
            conversations: 89,
            facts: 27
          }
        }
      ];
      isLoading = false;
    } catch (err) {
      console.error('Failed to load agents:', err);
      error = err.message;
      isLoading = false;
    }
  });

  function createNewAgent() {
    navigate('/agents/create');
  }

  function viewAgent(agent) {
    navigate(`/agents/${agent.id}`);
  }
</script>

<div class="container mx-auto p-6" in:fade class:opacity-50={isLoading}>
  <div class="bg-white rounded-lg shadow-md p-6 mb-8">
    <div class="flex justify-between items-center">
      <h1 class="text-2xl font-bold text-gray-900">AI Agents</h1>
      <button 
        class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition-colors flex items-center gap-2"
        on:click={createNewAgent}
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
        </svg>
        Create Agent
      </button>
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
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    {#each agents as agent}
      <div 
        class="bg-white rounded-lg shadow-md p-6 cursor-pointer transform transition-all hover:shadow-lg hover:-translate-y-1"
        on:click={() => viewAgent(agent)}
      >
        <div class="flex items-center gap-3 mb-4">
          <div class={`w-3 h-3 rounded-full ${agent.deployment?.autoStart ? 'bg-green-500' : 'bg-gray-500'}`}></div>
          <h3 class="text-xl font-semibold text-gray-900">{agent.name}</h3>
          <span class="text-sm text-gray-500">{agent.type}</span>
        </div>
        
        <div class="space-y-4 mb-6 mt-4">
          <div class="flex items-center justify-between">
            <span class="text-sm font-medium text-gray-500">Platform</span>
            <span class="text-sm text-gray-900">{agent.platform}</span>
          </div>
          <div class="flex items-center justify-between">
            <span class="text-sm font-medium text-gray-500">Last Active</span>
            <span class="text-sm text-gray-900">{agent.lastActive}</span>
          </div>
          <div class="bg-gray-50 p-3 rounded-lg">
            <div class="text-sm font-medium text-gray-500 mb-2">Memory Stats</div>
            <div class="grid grid-cols-2 gap-4">
              <div>
                <div class="text-2xl font-semibold text-gray-900">{agent.memory.conversations}</div>
                <div class="text-sm text-gray-500">Conversations</div>
              </div>
              <div>
                <div class="text-2xl font-semibold text-gray-900">{agent.memory.facts}</div>
                <div class="text-sm text-gray-500">Facts</div>
              </div>
            </div>
          </div>
        </div>

        <div class="flex gap-3">
          <button class="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-gray-100 text-gray-600 rounded-md hover:bg-gray-200 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
              <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
            </svg>
            Monitor
          </button>
          <button class="flex-1 flex items-center justify-center gap-2 px-4 py-2 bg-indigo-100 text-indigo-600 rounded-md hover:bg-indigo-200 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd" />
            </svg>
            Configure
          </button>
        </div>
      </div>
    {/each}
  </div>
  {/if}
</div>

<style>
  :global(body) {
    background-color: #f3f4f6;
  }
</style>
