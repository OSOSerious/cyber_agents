<script>
  import { onMount } from 'svelte';
  import { Link, navigate } from "svelte-routing";

  let templates = [];
  let filteredTemplates = [];
  let isLoading = true;
  let error = null;
  let searchQuery = '';
  let selectedCategory = 'all';

  onMount(async () => {
    // Simulated data - would be replaced with actual API call
    templates = [
      {
        id: 1,
        name: 'Tech Analyst',
        category: 'Business',
        description: 'Expert in analyzing technology trends and providing market insights',
        features: [
          'Market trend analysis',
          'Competitive research',
          'Technology forecasting',
          'Investment insights'
        ],
        complexity: 'Advanced',
        bestFor: 'Technology companies, investors, market researchers',
        thumbnail: '/tech-analyst-thumb.png'
      },
      {
        id: 2,
        name: 'Creative Writer',
        category: 'Content',
        description: 'Specialized in creating engaging content across various formats',
        features: [
          'Blog post writing',
          'Social media content',
          'Story development',
          'Content ideation'
        ],
        complexity: 'Intermediate',
        bestFor: 'Content creators, marketers, publishers',
        thumbnail: '/creative-writer-thumb.png'
      },
      {
        id: 3,
        name: 'Business Strategist',
        category: 'Business',
        description: 'Strategic advisor for business growth and transformation',
        features: [
          'Business planning',
          'Market entry strategy',
          'Growth analysis',
          'Risk assessment'
        ],
        complexity: 'Advanced',
        bestFor: 'Business owners, executives, consultants',
        thumbnail: '/business-strategist-thumb.png'
      }
    ];

    filteredTemplates = templates;
    isLoading = false;
  });

  function handleSearch() {
    if (searchQuery === '' && selectedCategory === 'all') {
      filteredTemplates = templates;
      return;
    }

    filteredTemplates = templates.filter(template => {
      const matchesSearch = searchQuery.toLowerCase() === '' ||
        template.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        template.description.toLowerCase().includes(searchQuery.toLowerCase());
      
      const matchesCategory = selectedCategory === 'all' || 
        template.category.toLowerCase() === selectedCategory.toLowerCase();
      
      return matchesSearch && matchesCategory;
    });
  }

  function handleCategoryChange(category) {
    selectedCategory = category;
    handleSearch();
  }

  $: {
    if (templates.length > 0) {
      handleSearch();
    }
  }
</script>

<div class="template-library">
  <header class="library-header">
    <div class="header-content">
      <h1>AI Agent Templates</h1>
      <p class="subtitle">Start with a pre-configured template or create your own custom agent</p>
    </div>
  </header>

  <div class="search-section">
    <div class="search-bar">
      <svg xmlns="http://www.w3.org/2000/svg" class="search-icon" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
      </svg>
      <input
        type="text"
        placeholder="Search templates..."
        bind:value={searchQuery}
        on:input={handleSearch}
      />
    </div>

    <div class="category-filters">
      <button 
        class="category-btn {selectedCategory === 'all' ? 'active' : ''}"
        on:click={() => handleCategoryChange('all')}
      >
        All
      </button>
      <button 
        class="category-btn {selectedCategory === 'business' ? 'active' : ''}"
        on:click={() => handleCategoryChange('business')}
      >
        Business
      </button>
      <button 
        class="category-btn {selectedCategory === 'content' ? 'active' : ''}"
        on:click={() => handleCategoryChange('content')}
      >
        Content
      </button>
      <button 
        class="category-btn {selectedCategory === 'support' ? 'active' : ''}"
        on:click={() => handleCategoryChange('support')}
      >
        Support
      </button>
    </div>
  </div>

  {#if isLoading}
    <div class="loading-state">
      <div class="spinner"></div>
      <p>Loading templates...</p>
    </div>
  {:else if error}
    <div class="error-state">
      <p>{error}</p>
    </div>
  {:else}
    <div class="templates-grid">
      {#each filteredTemplates as template}
        <div class="template-card">
          <div class="template-header">
            <h2>{template.name}</h2>
            <span class="category-tag">{template.category}</span>
          </div>
          
          <p class="description">{template.description}</p>
          
          <div class="features-list">
            <h3>Key Features</h3>
            <ul>
              {#each template.features as feature}
                <li>{feature}</li>
              {/each}
            </ul>
          </div>
          
          <div class="template-meta">
            <div class="meta-item">
              <span class="label">Complexity</span>
              <span class="value">{template.complexity}</span>
            </div>
            <div class="meta-item">
              <span class="label">Best For</span>
              <span class="value">{template.bestFor}</span>
            </div>
          </div>
          
          <div class="template-actions">
            <button 
              class="primary-btn"
              on:click={() => navigate(`/character-builder?template=${template.id}`)}
            >
              Use Template
            </button>
            <button 
              class="secondary-btn"
              on:click={() => navigate(`/character-builder?template=${template.id}&mode=customize`)}
            >
              Customize
            </button>
          </div>
        </div>
      {/each}
    </div>
  {/if}
</div>

<style>
  .template-library {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
  }

  .library-header {
    text-align: center;
    margin-bottom: 3rem;
    padding: 2rem;
    background: linear-gradient(135deg, #4f46e5 0%, #818cf8 100%);
    border-radius: 12px;
    color: white;
  }

  .library-header h1 {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
  }

  .subtitle {
    font-size: 1.1rem;
    opacity: 0.9;
  }

  .search-section {
    margin-bottom: 2rem;
  }

  .search-bar {
    position: relative;
    max-width: 600px;
    margin: 0 auto 1.5rem;
  }

  .search-icon {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    width: 20px;
    height: 20px;
    color: #6b7280;
  }

  .search-bar input {
    width: 100%;
    padding: 1rem 1rem 1rem 3rem;
    border: 2px solid #e5e7eb;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.2s;
  }

  .search-bar input:focus {
    outline: none;
    border-color: #4f46e5;
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
  }

  .category-filters {
    display: flex;
    justify-content: center;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .category-btn {
    padding: 0.5rem 1.5rem;
    border: none;
    border-radius: 20px;
    background: #f3f4f6;
    color: #4b5563;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
  }

  .category-btn:hover {
    background: #e5e7eb;
  }

  .category-btn.active {
    background: #4f46e5;
    color: white;
  }

  .templates-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
  }

  .template-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .template-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  }

  .template-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .template-header h2 {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
  }

  .category-tag {
    padding: 0.25rem 0.75rem;
    background: #f3f4f6;
    color: #4b5563;
    border-radius: 16px;
    font-size: 0.875rem;
    font-weight: 500;
  }

  .description {
    color: #6b7280;
    margin-bottom: 1.5rem;
    line-height: 1.5;
  }

  .features-list {
    margin-bottom: 1.5rem;
  }

  .features-list h3 {
    font-size: 1rem;
    font-weight: 600;
    color: #374151;
    margin-bottom: 0.75rem;
  }

  .features-list ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .features-list li {
    padding-left: 1.5rem;
    position: relative;
    margin-bottom: 0.5rem;
    color: #4b5563;
  }

  .features-list li::before {
    content: "•";
    position: absolute;
    left: 0.5rem;
    color: #4f46e5;
  }

  .template-meta {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
    margin-bottom: 1.5rem;
    padding: 1rem;
    background: #f9fafb;
    border-radius: 8px;
  }

  .meta-item {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .meta-item .label {
    font-size: 0.875rem;
    color: #6b7280;
  }

  .meta-item .value {
    font-weight: 500;
    color: #374151;
  }

  .template-actions {
    display: flex;
    gap: 1rem;
  }

  .primary-btn, .secondary-btn {
    flex: 1;
    padding: 0.75rem;
    border: none;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
  }

  .primary-btn {
    background: #4f46e5;
    color: white;
  }

  .primary-btn:hover {
    background: #4338ca;
  }

  .secondary-btn {
    background: white;
    border: 1px solid #e5e7eb;
    color: #4b5563;
  }

  .secondary-btn:hover {
    background: #f9fafb;
    border-color: #d1d5db;
  }

  .loading-state, .error-state {
    text-align: center;
    padding: 4rem;
    color: #6b7280;
  }

  .spinner {
    width: 40px;
    height: 40px;
    margin: 0 auto 1rem;
    border: 3px solid #f3f4f6;
    border-top-color: #4f46e5;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  @media (max-width: 768px) {
    .template-library {
      padding: 1rem;
    }

    .library-header {
      padding: 1.5rem;
      margin-bottom: 2rem;
    }

    .library-header h1 {
      font-size: 2rem;
    }

    .templates-grid {
      grid-template-columns: 1fr;
    }

    .template-actions {
      flex-direction: column;
    }
  }
</style>
