<script>
  import { onMount } from 'svelte';
  import { navigate } from 'svelte-routing';

  export let agentId;
  let agent = null;
  let isLoading = true;
  let error = null;
  let userRating = 0;
  let reviewText = '';
  let reviews = [];
  let averageRating = 0;
  let totalReviews = 0;
  let ratingDistribution = {
    5: 0,
    4: 0,
    3: 0,
    2: 0,
    1: 0
  };

  async function loadReviews() {
    // TODO: Replace with actual API call
    reviews = [
      {
        id: 1,
        userId: 'user1',
        userName: 'Sarah Johnson',
        rating: 5,
        review: 'Excellent AI agent! Helped me tremendously with market analysis.',
        date: '2023-12-01',
        helpful: 12
      },
      {
        id: 2,
        userId: 'user2',
        userName: 'Michael Chen',
        rating: 4,
        review: 'Very knowledgeable and responsive. Could improve on complex queries.',
        date: '2023-11-28',
        helpful: 8
      }
    ];

    // Calculate metrics
    totalReviews = reviews.length;
    averageRating = reviews.reduce((acc, r) => acc + r.rating, 0) / totalReviews;
    
    // Calculate rating distribution
    reviews.forEach(r => {
      ratingDistribution[r.rating]++;
    });
  }

  async function submitReview() {
    if (userRating === 0) {
      alert('Please select a rating');
      return;
    }
    
    // TODO: Replace with actual API call
    const newReview = {
      id: reviews.length + 1,
      userId: 'currentUser',
      userName: 'Current User',
      rating: userRating,
      review: reviewText,
      date: new Date().toISOString().split('T')[0],
      helpful: 0
    };
    
    reviews = [newReview, ...reviews];
    userRating = 0;
    reviewText = '';
    
    // Update metrics
    totalReviews++;
    averageRating = reviews.reduce((acc, r) => acc + r.rating, 0) / totalReviews;
    ratingDistribution[newReview.rating]++;
  }

  function markHelpful(reviewId) {
    reviews = reviews.map(review => 
      review.id === reviewId 
        ? { ...review, helpful: review.helpful + 1 }
        : review
    );
  }

  onMount(async () => {
    await loadReviews();
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
      agent = await response.json();
      await loadReviews();
      isLoading = false;
    } catch (err) {
      console.error('Failed to load agent:', err);
      error = err.message;
      isLoading = false;
    }
  });

  function getStatusColor(status) {
    return status ? 'bg-green-500' : 'bg-gray-500';
  }
</script>

<div class="container mx-auto px-4 py-8 max-w-7xl">
  <!-- Top Action Bar -->
  <div class="bg-white rounded-xl shadow-lg p-8 mb-8 border border-gray-100">
    <div class="flex justify-between items-start">
      <div>
        <div class="flex items-center gap-4 mb-3">
          <button 
            class="px-5 py-2.5 bg-white border border-gray-200 text-gray-700 rounded-lg hover:bg-gray-50 transition-all duration-200 flex items-center gap-2 font-medium shadow-sm"
            on:click={() => navigate('/agents')}
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L4.414 9H17a1 1 0 110 2H4.414l5.293 5.293a1 1 0 010 1.414z" clip-rule="evenodd" />
            </svg>
            Back
          </button>
          <h1 class="text-3xl font-bold text-gray-900">{agent?.name}</h1>
          <div class="flex items-center gap-2 px-3 py-1 rounded-full bg-opacity-10 {agent?.deployment?.autoStart ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'}">
            <span class={`inline-block w-2.5 h-2.5 rounded-full ${agent?.deployment?.autoStart ? 'bg-green-500' : 'bg-gray-500'}`}></span>
            <span class="text-sm font-medium">{agent?.deployment?.autoStart ? 'Active' : 'Inactive'}</span>
          </div>
        </div>
        <p class="text-lg text-gray-600 mb-6 leading-relaxed">{agent?.description}</p>
      </div>
      <div class="flex gap-2">
        <button class="bg-gray-100 text-gray-700 px-5 py-2.5 rounded-lg hover:bg-gray-200 transition-all duration-200 flex items-center gap-2 font-medium shadow-sm">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
            <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
          </svg>
          Edit
        </button>
        <button class="bg-indigo-100 text-indigo-700 px-5 py-2.5 rounded-lg hover:bg-indigo-200 transition-all duration-200 flex items-center gap-2 font-medium shadow-sm">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
          </svg>
          Deploy
        </button>
      </div>
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
    <!-- Navigation Tabs -->
    <div class="mb-8">
      <div class="border-b border-gray-200">
        <nav class="flex space-x-8">
          <button
            class="py-4 px-1 border-b-2 font-medium text-sm border-indigo-500 text-indigo-600"
          >
            Overview
          </button>
          <button
            class="py-4 px-1 border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
          >
            Settings
          </button>
        </nav>
      </div>
    </div>

    <!-- Agent Info Section -->
    <div class="bg-white rounded-xl shadow-lg p-8 mb-8 border border-gray-100">
      <div class="flex justify-between items-start">
        <div>
          <h1 class="text-2xl font-bold text-gray-900 mb-2">{agent.name}</h1>
          <p class="text-xl text-gray-600 mb-2">{agent.type}</p>
          <p class="text-gray-600 mb-4">{agent.description}</p>
          <div class="flex gap-4">
            <div class="px-4 py-1.5 bg-blue-50 text-blue-700 rounded-full text-sm font-medium border border-blue-100 hover:bg-blue-100 transition-colors">
              {agent.modelProvider}
            </div>
            <div class="px-4 py-1.5 bg-purple-50 text-purple-700 rounded-full text-sm font-medium border border-purple-100 hover:bg-purple-100 transition-colors">
              {agent.settings?.model}
            </div>
            <div class="px-4 py-1.5 bg-gray-50 text-gray-700 rounded-full text-sm font-medium border border-gray-100 hover:bg-gray-100 transition-colors">
              v{agent.version}
            </div>
          </div>
        </div>
        <div class="flex flex-col items-end gap-2">
          {#if agent.clients?.length}
            <div class="flex gap-2">
              {#each agent.clients as client}
                <div class="px-3 py-1 bg-indigo-100 text-indigo-800 rounded-full text-sm font-medium capitalize">
                  {client}
                </div>
              {/each}
            </div>
          {/if}
        </div>
      </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <!-- Bio and Expertise -->
      <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
          </svg>
          Bio & Expertise
        </h2>
        <div class="space-y-4">
          <div>
            <h3 class="text-lg font-semibold text-gray-800 mb-3 flex items-center gap-2">
              <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
              Background
            </h3>
            <ul class="space-y-3 pl-4">
              {#each agent.bio || [] as item}
                <li class="text-gray-600 leading-relaxed flex items-start gap-2">
                  <span class="text-indigo-500 mt-1.5">•</span>
                  <span>{item}</span>
                </li>
              {/each}
            </ul>
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-800 mb-3 flex items-center gap-2 mt-6">
              <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
              Knowledge Base
            </h3>
            <ul class="space-y-3 pl-4">
              {#each agent.knowledge || [] as item}
                <li class="text-gray-600 leading-relaxed flex items-start gap-2">
                  <span class="text-indigo-500 mt-1.5">•</span>
                  <span>{item}</span>
                </li>
              {/each}
            </ul>
          </div>
        </div>
      </div>

      <!-- Topics and Style -->
      <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
          </svg>
          Specialization & Approach
        </h2>
        <div class="space-y-4">
          <div>
            <h3 class="text-lg font-semibold text-gray-800 mb-3 flex items-center gap-2">
              <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
              Topics
            </h3>
            <div class="flex flex-wrap gap-2 mb-6">
              {#each agent.topics || [] as topic}
                <span class="px-4 py-1.5 bg-indigo-50 text-indigo-700 rounded-full text-sm font-medium border border-indigo-100 hover:bg-indigo-100 transition-colors">
                  {topic}
                </span>
              {/each}
            </div>
          </div>
          {#if agent.style}
            <div>
              <h3 class="text-lg font-medium text-gray-900 mb-2">Communication Style</h3>
              <div class="space-y-3">
                {#each Object.entries(agent.style) as [type, points]}
                  <div>
              <h4 class="text-base font-semibold text-gray-800 capitalize mb-2 flex items-center gap-2">
                <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                {type}
              </h4>
              <ul class="space-y-2 pl-4">
                      {#each points as point}
                        <li class="text-gray-600 leading-relaxed flex items-start gap-2">
                    <span class="text-indigo-500 mt-1.5">•</span>
                    <span>{point}</span>
                  </li>
                      {/each}
                    </ul>
                  </div>
                {/each}
              </div>
            </div>
          {/if}
        </div>
      </div>

      <!-- Capabilities and Metrics -->
      <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
          </svg>
          Capabilities & Performance
        </h2>
        <div class="space-y-6">
          {#if agent.capabilities}
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-3 flex items-center gap-2">
                <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                Core Capabilities
              </h3>
              {#each Object.entries(agent.capabilities) as [category, items]}
                <div class="mb-4">
                  <h4 class="text-base font-semibold text-gray-800 capitalize mb-2 flex items-center gap-2">
                    <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                    {category}
                  </h4>
                  <ul class="space-y-2 pl-4">
                    {#each items as item}
                      <li class="text-gray-600 leading-relaxed flex items-start gap-2">
                        <span class="text-indigo-500 mt-1.5">•</span>
                        <span>{item}</span>
                      </li>
                    {/each}
                  </ul>
                </div>
              {/each}
            </div>
          {/if}
          {#if agent.metrics}
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2 mt-6">
                <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                Performance Metrics
              </h3>
              <div class="grid grid-cols-3 gap-4">
                <div class="bg-gray-50 p-5 rounded-xl hover:bg-gray-100 transition-all duration-200 border border-gray-100">
                  <div class="text-sm font-medium text-gray-500 mb-2">Interactions</div>
                  <div class="text-2xl font-bold text-gray-900 flex items-baseline gap-1">
                    {agent.metrics.interactions}
                    <span class="text-sm font-normal text-gray-500">total</span>
                  </div>
                </div>
                <div class="bg-gray-50 p-5 rounded-xl hover:bg-gray-100 transition-all duration-200 border border-gray-100">
                  <div class="text-sm font-medium text-gray-500 mb-2">Response Time</div>
                  <div class="text-2xl font-bold text-gray-900 flex items-baseline gap-1">
                    {agent.metrics.responseTime}
                    <span class="text-sm font-normal text-gray-500">sec</span>
                  </div>
                </div>
                <div class="bg-gray-50 p-5 rounded-xl hover:bg-gray-100 transition-all duration-200 border border-gray-100">
                  <div class="text-sm font-medium text-gray-500 mb-2">Accuracy</div>
                  <div class="text-2xl font-bold text-green-600 flex items-baseline gap-1">
                    {agent.metrics.accuracy}
                    <span class="text-sm font-normal text-gray-500">%</span>
                  </div>
                </div>
              </div>
            </div>
          {/if}
        </div>
      </div>

      <!-- Character Stats -->
      {#if agent.characterStats}
        <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
          <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
            </svg>
            Character Profile
          </h2>
          <div class="space-y-6">
            <div class="grid grid-cols-2 gap-4">
              {#each Object.entries(agent.characterStats) as [stat, value]}
                {#if typeof value === 'number'}
                  <div>
                    <div class="flex justify-between items-center mb-2">
                      <span class="text-sm font-semibold text-gray-800 capitalize">{stat}</span>
                      <span class="text-sm font-medium text-gray-600">{value}/10</span>
                    </div>
                    <div class="w-full bg-gray-100 rounded-full h-2.5 border border-gray-200">
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
                <h3 class="text-lg font-semibold text-gray-800 mb-3 flex items-center gap-2">
                  <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                  Daily Routine
                </h3>
                <ul class="space-y-3 pl-4">
                  {#each agent.characterStats.routine as item}
                    <li class="text-gray-600 leading-relaxed flex items-start gap-2">
                      <span class="text-indigo-500 mt-1.5">•</span>
                      <span>{item}</span>
                    </li>
                  {/each}
                </ul>
              </div>
            {/if}
          </div>
        </div>
      {/if}
    </div>

    <!-- Deployment Information -->
    {#if agent.deployment}
      <div class="mt-8 bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
          </svg>
          Deployment Configuration
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div>
            <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
              Environment
            </h3>
            <div class="space-y-3 bg-gray-50 p-4 rounded-lg border border-gray-100">
              <div>
                <span class="text-sm font-medium text-gray-500">Type</span>
                <p class="text-gray-900 capitalize">{agent.deployment.environment}</p>
              </div>
              <div>
                <span class="text-sm font-medium text-gray-500">Auto-Start</span>
                <p class="text-gray-900">{agent.deployment.autoStart ? 'Enabled' : 'Disabled'}</p>
              </div>
            </div>
          </div>

          {#if agent.deployment.schedule}
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
                <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                Schedule
              </h3>
              <div class="space-y-3 bg-gray-50 p-4 rounded-lg border border-gray-100">
                <div>
                  <span class="text-sm font-medium text-gray-500">Status</span>
                  <p class="text-gray-900">{agent.deployment.schedule.active ? 'Active' : 'Inactive'}</p>
                </div>
                <div>
                  <span class="text-sm font-medium text-gray-500">Timezone</span>
                  <p class="text-gray-900">{agent.deployment.schedule.timezone}</p>
                </div>
                {#if agent.deployment.schedule.availability?.[0]}
                  <div>
                    <span class="text-sm font-medium text-gray-500">Available Days</span>
                    <p class="text-gray-900 capitalize">
                      {agent.deployment.schedule.availability[0].days.join(', ')}
                    </p>
                    <span class="text-sm font-medium text-gray-500">Hours</span>
                    <p class="text-gray-900">
                      {agent.deployment.schedule.availability[0].hours.join(', ')}
                    </p>
                  </div>
                {/if}
              </div>
            </div>
          {/if}

          {#if agent.deployment.monitoring}
            <div>
              <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center gap-2">
                <span class="w-1.5 h-1.5 bg-indigo-500 rounded-full"></span>
                Monitoring
              </h3>
              <div class="space-y-3 bg-gray-50 p-4 rounded-lg border border-gray-100">
                <div>
                  <span class="text-sm font-medium text-gray-500">Status</span>
                  <p class="text-gray-900">{agent.deployment.monitoring.enabled ? 'Enabled' : 'Disabled'}</p>
                </div>
                <div>
                  <span class="text-sm font-medium text-gray-500">Tracked Metrics</span>
                  <p class="text-gray-900 capitalize">
                    {agent.deployment.monitoring.metrics.join(', ').replace(/_/g, ' ')}
                  </p>
                </div>
                {#if agent.deployment.monitoring.alerts}
                  <div>
                    <span class="text-sm font-medium text-gray-500">Alert Thresholds</span>
                    <ul class="list-disc list-inside">
                      {#each Object.entries(agent.deployment.monitoring.alerts) as [metric, value]}
                        <li class="text-gray-900">
                          {metric.replace(/_/g, ' ')}: {value}
                        </li>
                      {/each}
                    </ul>
                  </div>
                {/if}
              </div>
            </div>
          {/if}
        </div>
      </div>
    {/if}

    <!-- Reviews and Ratings Section -->
    <div class="mt-8 bg-white rounded-xl shadow-lg p-8 border border-gray-100">
      <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center gap-3">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
        </svg>
        Reviews & Ratings
      </h2>
      
      <!-- Rating Summary -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="text-center">
          <div class="text-4xl font-bold text-gray-900">{averageRating.toFixed(1)}</div>
          <div class="flex justify-center my-2">
            {#each Array(5) as _, i}
              <svg class={`w-5 h-5 ${i < Math.floor(averageRating) ? 'text-yellow-400' : 'text-gray-300'}`} 
                fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
              </svg>
            {/each}
          </div>
          <div class="text-sm text-gray-500">{totalReviews} reviews</div>
        </div>
        
        <div class="space-y-2">
          {#each Array(5).reverse() as _, i}
            <div class="flex items-center">
              <span class="text-sm text-gray-600 w-8">{i + 1}</span>
              <div class="flex-1 h-2 mx-2 bg-gray-200 rounded-full">
                <div 
                  class="h-2 bg-yellow-400 rounded-full" 
                  style="width: {(ratingDistribution[i + 1] / totalReviews * 100) || 0}%"
                ></div>
              </div>
              <span class="text-sm text-gray-600 w-8">{ratingDistribution[i + 1] || 0}</span>
            </div>
          {/each}
        </div>

        <!-- Write Review Form -->
        <div class="bg-gray-50 p-6 rounded-xl border border-gray-100">
          <h3 class="text-lg font-semibold text-gray-800 mb-4">Write a Review</h3>
          <div class="flex mb-2">
            {#each Array(5) as _, i}
              <button 
                class="p-1"
                on:click={() => userRating = i + 1}
              >
                <svg class={`w-6 h-6 ${i < userRating ? 'text-yellow-400' : 'text-gray-300'}`} 
                  fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </button>
            {/each}
          </div>
          <textarea
            class="w-full p-3 border border-gray-200 rounded-lg mb-3 focus:ring-2 focus:ring-indigo-200 focus:border-indigo-500 transition-all duration-200"
            placeholder="Write your review..."
            bind:value={reviewText}
          ></textarea>
          <button 
            class="w-full bg-indigo-600 text-white px-5 py-3 rounded-lg hover:bg-indigo-700 transition-all duration-200 font-medium shadow-sm"
            on:click={submitReview}
          >
            Submit Review
          </button>
        </div>
      </div>

      <!-- Reviews List -->
      <div class="space-y-6">
        {#each reviews as review}
          <div class="border-b border-gray-200 pb-6 hover:bg-gray-50 p-4 rounded-lg transition-all duration-200">
            <div class="flex justify-between items-start mb-2">
              <div>
                <div class="flex items-center">
                  <div class="flex">
                    {#each Array(5) as _, i}
                      <svg class={`w-4 h-4 ${i < review.rating ? 'text-yellow-400' : 'text-gray-300'}`} 
                        fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                      </svg>
                    {/each}
                  </div>
                  <span class="ml-2 text-sm text-gray-500">{review.date}</span>
                </div>
                <p class="font-medium text-gray-900 mt-1">{review.userName}</p>
              </div>
              <button 
                class="flex items-center text-sm text-gray-500 hover:text-gray-700"
                on:click={() => markHelpful(review.id)}
              >
                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5" />
                </svg>
                Helpful ({review.helpful})
              </button>
            </div>
            <p class="text-gray-700">{review.review}</p>
          </div>
        {/each}
      </div>
    </div>
  {/if}
</div>

<style>
  :global(body) {
    background-color: #f3f4f6;
  }

  /* Animation for loading spinner */
  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  .animate-spin {
    animation: spin 1s linear infinite;
  }
</style>
