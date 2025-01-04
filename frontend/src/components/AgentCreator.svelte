<script>
  import { createEventDispatcher } from 'svelte';
  import { fade } from 'svelte/transition';

  const dispatch = createEventDispatcher();

  let name = '';
  let type = '';
  let description = '';
  let selectedPlatform = '';
  let modelProvider = 'GPT-4';
  let version = '1.0';
  let deployment = {
    environment: 'production',
    autoStart: true
  };
  let personality = {
    traits: [],
    knowledge: [],
    behavior: []
  };
  let customActions = [];
  let customEvaluators = [];

  const platforms = [
    { id: 'discord', name: 'Discord', icon: 'discord.svg' },
    { id: 'telegram', name: 'Telegram', icon: 'telegram.svg' },
    { id: 'direct', name: 'Direct API', icon: 'api.svg' }
  ];

  const availableTraits = [
    'Friendly', 'Professional', 'Technical', 'Creative', 'Analytical'
  ];

  const availableActions = [
    { id: 'transcribe', name: 'Transcribe Media' },
    { id: 'generate_image', name: 'Generate Images' },
    { id: 'follow_room', name: 'Follow Conversations' },
    { id: 'process_document', name: 'Process Documents' }
  ];

  const availableEvaluators = [
    { id: 'fact', name: 'Fact Extraction' },
    { id: 'goal', name: 'Goal Tracking' },
    { id: 'memory', name: 'Memory Building' }
  ];

  function addTrait(trait) {
    personality.traits = [...personality.traits, trait];
  }

  function removeTrait(trait) {
    personality.traits = personality.traits.filter(t => t !== trait);
  }

  function toggleAction(actionId) {
    if (customActions.includes(actionId)) {
      customActions = customActions.filter(id => id !== actionId);
    } else {
      customActions = [...customActions, actionId];
    }
  }

  function toggleEvaluator(evaluatorId) {
    if (customEvaluators.includes(evaluatorId)) {
      customEvaluators = customEvaluators.filter(id => id !== evaluatorId);
    } else {
      customEvaluators = [...customEvaluators, evaluatorId];
    }
  }

  function createAgent() {
    const agent = {
      name,
      type,
      description,
      platform: selectedPlatform,
      modelProvider,
      version,
      deployment: {
        environment: deployment.environment,
        autoStart: deployment.autoStart
      },
      personality: {
        traits: personality.traits,
        knowledge: personality.knowledge.split('\n').filter(k => k.trim()),
        behavior: personality.behavior
      },
      capabilities: {
        actions: customActions.map(id => {
          const action = availableActions.find(a => a.id === id);
          return action.name;
        }),
        evaluators: customEvaluators.map(id => {
          const evaluator = availableEvaluators.find(e => e.id === id);
          return evaluator.name;
        })
      }
    };

    dispatch('create', agent);
  }

  function cancel() {
    dispatch('cancel');
  }
</script>

<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" in:fade>
  <div class="bg-white rounded-xl w-[90%] max-w-4xl max-h-[90vh] flex flex-col" in:fade>
    <div class="px-6 py-4 border-b border-gray-200 flex justify-between items-center">
      <h2 class="text-2xl font-bold text-gray-900">Create New Agent</h2>
      <button 
        class="text-gray-400 hover:text-gray-500 transition-colors"
        on:click={cancel}
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </div>

    <div class="p-6 overflow-y-auto">
      <div class="space-y-8">
        <!-- Basic Information -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Basic Information</h3>
          <div class="space-y-4">
            <div>
              <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Agent Name</label>
              <input 
                type="text" 
                id="name" 
                bind:value={name} 
                placeholder="Enter agent name"
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>
            <div>
              <label for="type" class="block text-sm font-medium text-gray-700 mb-1">Agent Type</label>
              <input 
                type="text" 
                id="type" 
                bind:value={type} 
                placeholder="e.g., Technology Analyst, Creative Writer"
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>
            <div>
              <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
              <textarea 
                id="description" 
                bind:value={description} 
                placeholder="Describe your agent's purpose and capabilities"
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 h-24"
              ></textarea>
            </div>
          </div>
        </section>

        <!-- Model Configuration -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Model Configuration</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="modelProvider" class="block text-sm font-medium text-gray-700 mb-1">Model Provider</label>
              <select 
                id="modelProvider" 
                bind:value={modelProvider}
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500"
              >
                <option value="GPT-4">GPT-4</option>
                <option value="GPT-3.5">GPT-3.5</option>
                <option value="Claude">Claude</option>
              </select>
            </div>
            <div>
              <label for="version" class="block text-sm font-medium text-gray-700 mb-1">Version</label>
              <input 
                type="text" 
                id="version" 
                bind:value={version} 
                placeholder="e.g., 1.0"
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>
          </div>
        </section>

        <!-- Platform Integration -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Platform Integration</h3>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
            {#each platforms as platform}
              <button 
                class="flex flex-col items-center p-4 border rounded-lg transition-all hover:shadow-md"
                class:ring-2={selectedPlatform === platform.id}
                class:ring-indigo-500={selectedPlatform === platform.id}
                class:bg-indigo-50={selectedPlatform === platform.id}
                on:click={() => selectedPlatform = platform.id}
              >
                <img src={platform.icon} alt={platform.name} class="w-8 h-8 mb-2" />
                <span class="text-sm font-medium text-gray-900">{platform.name}</span>
              </button>
            {/each}
          </div>
        </section>

        <!-- Personality & Knowledge -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Personality & Knowledge</h3>
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Traits</label>
              <div class="flex flex-wrap gap-2">
                {#each availableTraits as trait}
                  <button 
                    class="px-4 py-2 rounded-full text-sm font-medium transition-colors"
                    class:bg-indigo-100={personality.traits.includes(trait)}
                    class:text-indigo-700={personality.traits.includes(trait)}
                    class:bg-gray-100={!personality.traits.includes(trait)}
                    class:text-gray-700={!personality.traits.includes(trait)}
                    on:click={() => personality.traits.includes(trait) ? removeTrait(trait) : addTrait(trait)}
                  >
                    {trait}
                  </button>
                {/each}
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Knowledge Base</label>
              <textarea 
                bind:value={personality.knowledge} 
                placeholder="Enter key knowledge areas, separated by new lines"
                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-indigo-500 focus:border-indigo-500 h-24"
              ></textarea>
            </div>
          </div>
        </section>

        <!-- Deployment Configuration -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Deployment Configuration</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Environment</h4>
              <div class="space-y-2">
                <label class="flex items-center">
                  <input 
                    type="radio" 
                    name="environment" 
                    value="production"
                    bind:group={deployment.environment}
                    class="text-indigo-600 focus:ring-indigo-500"
                  />
                  <span class="ml-2 text-gray-700">Production</span>
                </label>
                <label class="flex items-center">
                  <input 
                    type="radio" 
                    name="environment" 
                    value="staging"
                    bind:group={deployment.environment}
                    class="text-indigo-600 focus:ring-indigo-500"
                  />
                  <span class="ml-2 text-gray-700">Staging</span>
                </label>
              </div>
            </div>
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Auto-Start</h4>
              <label class="flex items-center">
                <input 
                  type="checkbox"
                  bind:checked={deployment.autoStart}
                  class="text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-gray-700">Enable auto-start on deployment</span>
              </label>
            </div>
          </div>
        </section>

        <!-- Capabilities -->
        <section>
          <h3 class="text-lg font-semibold text-gray-900 mb-4">Capabilities</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Actions</h4>
              <div class="space-y-2">
                {#each availableActions as action}
                  <label class="flex items-center">
                    <input 
                      type="checkbox"
                      checked={customActions.includes(action.id)}
                      on:change={() => toggleAction(action.id)}
                      class="text-indigo-600 focus:ring-indigo-500"
                    />
                    <span class="ml-2 text-gray-700">{action.name}</span>
                  </label>
                {/each}
              </div>
            </div>
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Evaluators</h4>
              <div class="space-y-2">
                {#each availableEvaluators as evaluator}
                  <label class="flex items-center">
                    <input 
                      type="checkbox"
                      checked={customEvaluators.includes(evaluator.id)}
                      on:change={() => toggleEvaluator(evaluator.id)}
                      class="text-indigo-600 focus:ring-indigo-500"
                    />
                    <span class="ml-2 text-gray-700">{evaluator.name}</span>
                  </label>
                {/each}
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>

    <div class="px-6 py-4 border-t border-gray-200 flex justify-end gap-3">
      <button 
        class="px-4 py-2 text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors"
        on:click={cancel}
      >
        Cancel
      </button>
      <button 
        class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors"
        on:click={createAgent}
      >
        Create Agent
      </button>
    </div>
  </div>
</div>

<style>
  .creator-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .creator-container {
    background: white;
    border-radius: 1rem;
    width: 90%;
    max-width: 800px;
    max-height: 90vh;
    display: flex;
    flex-direction: column;
  }

  .creator-header {
    padding: 1.5rem;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .creator-header h2 {
    margin: 0;
    font-size: 1.5rem;
    color: #1a1a1a;
  }

  .close-btn {
    background: none;
    border: none;
    font-size: 1.5rem;
    color: #6b7280;
    cursor: pointer;
  }

  .creator-content {
    padding: 1.5rem;
    overflow-y: auto;
  }

  .form-section {
    margin-bottom: 2rem;
  }

  .form-section h3 {
    margin: 0 0 1rem 0;
    font-size: 1.25rem;
    color: #1a1a1a;
  }

  .form-group {
    margin-bottom: 1rem;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
    color: #4b5563;
    font-weight: 500;
  }

  input[type="text"],
  textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    font-size: 1rem;
  }

  textarea {
    height: 100px;
    resize: vertical;
  }

  .platform-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
    gap: 1rem;
  }

  .platform-btn {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    padding: 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    background: white;
    cursor: pointer;
    transition: all 0.2s;
  }

  .platform-btn.selected {
    border-color: #4f46e5;
    background: #f5f3ff;
  }

  .platform-btn img {
    width: 2rem;
    height: 2rem;
  }

  .traits-container {
    background: #f9fafb;
    padding: 1rem;
    border-radius: 0.5rem;
  }

  .available-traits {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .trait-btn {
    padding: 0.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 2rem;
    background: white;
    color: #4b5563;
    cursor: pointer;
    transition: all 0.2s;
  }

  .trait-btn.selected {
    background: #4f46e5;
    color: white;
    border-color: #4f46e5;
  }

  .capabilities-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
  }

  .capability-section h4 {
    margin: 0 0 1rem 0;
    color: #4b5563;
  }

  .capability-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
    cursor: pointer;
  }

  .creator-footer {
    padding: 1.5rem;
    border-top: 1px solid #e5e7eb;
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
  }

  .primary-btn,
  .secondary-btn {
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .primary-btn {
    background: #4f46e5;
    color: white;
    border: none;
  }

  .primary-btn:hover {
    background: #4338ca;
  }

  .secondary-btn {
    background: white;
    color: #4b5563;
    border: 1px solid #e5e7eb;
  }

  .secondary-btn:hover {
    background: #f9fafb;
  }

  @media (max-width: 640px) {
    .creator-container {
      width: 100%;
      height: 100%;
      max-height: none;
      border-radius: 0;
    }

    .capabilities-grid {
      grid-template-columns: 1fr;
    }
  }
</style>
