<script>
  import { onMount } from 'svelte';

  let jsonEditor = '';
  let currentCharacter = null;
  let loadError = '';
  let characters = [
    {
      name: 'Tech Analyst',
      path: '/tech-analyst-character.json',
      description: 'AI analyst specializing in emerging technologies and market trends'
    },
    {
      name: 'Creative Writer',
      path: '/creative-writer-character.json',
      description: 'Digital storyteller crafting compelling narratives across genres'
    },
    {
      name: 'Business Strategist',
      path: '/business-strategist-character.json',
      description: 'Strategic advisor for business transformation and growth'
    }
  ];

  let currentStep = 'template';
  let steps = ['template', 'training', 'capabilities', 'deployment', 'preview'];
  
  function nextStep() {
    const currentIndex = steps.indexOf(currentStep);
    if (currentIndex < steps.length - 1) {
      currentStep = steps[currentIndex + 1];
    }
  }

  function previousStep() {
    const currentIndex = steps.indexOf(currentStep);
    if (currentIndex > 0) {
      currentStep = steps[currentIndex - 1];
    }
  }

  function updateField(path, value) {
    let current = currentCharacter;
    const parts = path.split('.');
    const lastPart = parts.pop();
    
    for (const part of parts) {
      if (!current[part]) {
        current[part] = {};
      }
      current = current[part];
    }
    
    current[lastPart] = value;
    jsonEditor = JSON.stringify(currentCharacter, null, 2);
  }

  async function loadCharacterFromUrl(url) {
    try {
      const response = await fetch(url);
      const data = await response.json();
      currentCharacter = data;
      jsonEditor = JSON.stringify(data, null, 2);
      loadError = '';
    } catch (error) {
      loadError = `Failed to load character: ${error.message}`;
    }
  }

  function handleFileUpload(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        try {
          const data = JSON.parse(e.target.result);
          currentCharacter = data;
          jsonEditor = JSON.stringify(data, null, 2);
          loadError = '';
        } catch (error) {
          loadError = 'Invalid JSON file';
        }
      };
      reader.readAsText(file);
    }
  }

  function updateJson() {
    try {
      currentCharacter = JSON.parse(jsonEditor);
      loadError = '';
    } catch (error) {
      loadError = 'Invalid JSON format';
    }
  }

  function downloadJson() {
    try {
      const blob = new Blob([jsonEditor], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `${currentCharacter?.name || 'character'}.json`;
      a.click();
      URL.revokeObjectURL(url);
    } catch (error) {
      loadError = 'Failed to download JSON';
    }
  }
</script>

<div class="container">
  <header>
    <h1>AI Character Builder</h1>
    <div class="actions">
      <button class="primary" on:click={downloadJson}>Export Character Config</button>
      <label class="upload-btn">
        Import Config
        <input 
          type="file" 
          accept=".json"
          on:change={handleFileUpload}
          style="display: none;"
        >
      </label>
    </div>
  </header>

  <div class="steps">
    <div class="step" class:active={currentStep === 'template'}>1. Template Selection</div>
    <div class="step" class:active={currentStep === 'training'}>2. Training Configuration</div>
    <div class="step" class:active={currentStep === 'capabilities'}>3. Capabilities</div>
    <div class="step" class:active={currentStep === 'deployment'}>4. Deployment Settings</div>
    <div class="step" class:active={currentStep === 'preview'}>5. Preview</div>
  </div>

  <div class="content">
    <div class="templates" class:hidden={currentStep !== 'template'}>
      <h2>Character Templates</h2>
      <div class="template-list">
        {#each characters as character}
          <div 
            class="template-card"
            on:click={() => loadCharacterFromUrl(character.path)}
            on:keydown={(e) => e.key === 'Enter' && loadCharacterFromUrl(character.path)}
            tabindex="0"
            role="button"
          >
            <h3>{character.name}</h3>
            <p>{character.description}</p>
          </div>
        {/each}
      </div>
    </div>

    <div class="training-section" class:hidden={currentStep !== 'training'}>
      <h2>Training Configuration</h2>
      <div class="training-form">
        <div class="form-group">
          <h3>Model Provider</h3>
          <label>
            Provider
            <select 
              value={currentCharacter?.modelProvider || ''}
              on:change={(e) => updateField('modelProvider', e.target.value)}
            >
              <option value="anthropic">Anthropic</option>
              <option value="openai">OpenAI</option>
              <option value="llama_local">Llama Local</option>
            </select>
          </label>
          <label>
            Model
            <select 
              value={currentCharacter?.settings?.model || ''}
              on:change={(e) => updateField('settings.model', e.target.value)}
            >
              <option value="claude-3-opus-20240229">Claude 3 Opus</option>
              <option value="gpt-4">GPT-4</option>
              <option value="llama-3-70b">Llama 3 70B</option>
            </select>
          </label>
        </div>
        <div class="form-group">
          <h3>Bio & Background</h3>
          <label>
            Bio (one per line)
            <textarea
              value={currentCharacter?.bio?.join('\n') || ''}
              on:input={(e) => updateField('bio', e.target.value.split('\n').filter(b => b.trim()))}
              rows="3"
              placeholder="Enter biographical information, one statement per line"
            ></textarea>
          </label>
          <label>
            Lore (one per line)
            <textarea
              value={currentCharacter?.lore?.join('\n') || ''}
              on:input={(e) => updateField('lore', e.target.value.split('\n').filter(l => l.trim()))}
              rows="3"
              placeholder="Enter background lore, one statement per line"
            ></textarea>
          </label>
        </div>
        <div class="form-group">
          <h3>Knowledge & Topics</h3>
          <label>
            Topics (comma-separated)
            <input 
              type="text" 
              value={currentCharacter?.topics?.join(', ') || ''}
              on:input={(e) => updateField('topics', e.target.value.split(',').map(t => t.trim()))}
              placeholder="AI, technology, business, etc."
            >
          </label>
          <label>
            Knowledge Base (one per line)
            <textarea
              value={currentCharacter?.knowledge?.join('\n') || ''}
              on:input={(e) => updateField('knowledge', e.target.value.split('\n').filter(k => k.trim()))}
              rows="4"
              placeholder="Enter knowledge statements, one per line"
            ></textarea>
          </label>
        </div>
      </div>
    </div>

    <div class="capabilities-section" class:hidden={currentStep !== 'capabilities'}>
      <h2>Agent Capabilities</h2>
      <div class="capabilities-form">
        <div class="form-group">
          <h3>Analysis Capabilities</h3>
          <label>
            Analysis Skills (one per line)
            <textarea
              value={currentCharacter?.capabilities?.analysis?.join('\n') || ''}
              on:input={(e) => updateField('capabilities.analysis', e.target.value.split('\n').filter(s => s.trim()))}
              rows="4"
              placeholder="Enter analysis capabilities, one per line"
            ></textarea>
          </label>
        </div>
        <div class="form-group">
          <h3>Reporting Capabilities</h3>
          <label>
            Report Types (one per line)
            <textarea
              value={currentCharacter?.capabilities?.reporting?.join('\n') || ''}
              on:input={(e) => updateField('capabilities.reporting', e.target.value.split('\n').filter(s => s.trim()))}
              rows="4"
              placeholder="Enter reporting capabilities, one per line"
            ></textarea>
          </label>
        </div>
        <div class="form-group">
          <h3>Monitoring Capabilities</h3>
          <label>
            Monitoring Tasks (one per line)
            <textarea
              value={currentCharacter?.capabilities?.monitoring?.join('\n') || ''}
              on:input={(e) => updateField('capabilities.monitoring', e.target.value.split('\n').filter(s => s.trim()))}
              rows="4"
              placeholder="Enter monitoring capabilities, one per line"
            ></textarea>
          </label>
        </div>
      </div>
    </div>

    <div class="deployment-section" class:hidden={currentStep !== 'deployment'}>
      <h2>Deployment Settings</h2>
      <div class="deployment-form">
        <div class="form-group">
          <h3>Environment Settings</h3>
          <label>
            Environment
            <select 
              value={currentCharacter?.deployment?.environment || 'development'}
              on:change={(e) => updateField('deployment.environment', e.target.value)}
            >
              <option value="development">Development</option>
              <option value="staging">Staging</option>
              <option value="production">Production</option>
            </select>
          </label>
          <label class="checkbox-label">
            <input 
              type="checkbox" 
              checked={currentCharacter?.deployment?.autoStart || false}
              on:change={(e) => updateField('deployment.autoStart', e.target.checked)}
            >
            Auto-start agent on deployment
          </label>
        </div>

        <div class="form-group">
          <h3>Schedule Configuration</h3>
          <label class="checkbox-label">
            <input 
              type="checkbox" 
              checked={currentCharacter?.deployment?.schedule?.active || false}
              on:change={(e) => updateField('deployment.schedule.active', e.target.checked)}
            >
            Enable scheduled availability
          </label>
          <label>
            Timezone
            <select 
              value={currentCharacter?.deployment?.schedule?.timezone || 'UTC'}
              on:change={(e) => updateField('deployment.schedule.timezone', e.target.value)}
            >
              <option value="UTC">UTC</option>
              <option value="America/New_York">Eastern Time</option>
              <option value="America/Chicago">Central Time</option>
              <option value="America/Denver">Mountain Time</option>
              <option value="America/Los_Angeles">Pacific Time</option>
            </select>
          </label>
          <div class="schedule-grid">
            {#each ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'] as day}
              <label class="checkbox-label">
                <input 
                  type="checkbox" 
                  checked={currentCharacter?.deployment?.schedule?.availability?.[0]?.days?.includes(day) || false}
                  on:change={(e) => {
                    const schedule = currentCharacter?.deployment?.schedule || {};
                    const availability = schedule.availability?.[0] || { days: [], hours: ['09:00-17:00'] };
                    if (e.target.checked) {
                      availability.days = [...new Set([...(availability.days || []), day])];
                    } else {
                      availability.days = availability.days.filter(d => d !== day);
                    }
                    updateField('deployment.schedule.availability', [availability]);
                  }}
                >
                {day.charAt(0).toUpperCase() + day.slice(1)}
              </label>
            {/each}
          </div>
          <label>
            Hours (HH:MM-HH:MM)
            <input 
              type="text" 
              value={currentCharacter?.deployment?.schedule?.availability?.[0]?.hours?.[0] || '09:00-17:00'}
              on:input={(e) => {
                const schedule = currentCharacter?.deployment?.schedule || {};
                const availability = schedule.availability?.[0] || { days: [], hours: [] };
                availability.hours = [e.target.value];
                updateField('deployment.schedule.availability', [availability]);
              }}
              placeholder="09:00-17:00"
            >
          </label>
        </div>

        <div class="form-group">
          <h3>Monitoring Configuration</h3>
          <label class="checkbox-label">
            <input 
              type="checkbox" 
              checked={currentCharacter?.deployment?.monitoring?.enabled || false}
              on:change={(e) => updateField('deployment.monitoring.enabled', e.target.checked)}
            >
            Enable performance monitoring
          </label>
          <label>
            Response Time Threshold (seconds)
            <input 
              type="number" 
              value={currentCharacter?.deployment?.monitoring?.alerts?.response_time_threshold || 5}
              on:input={(e) => updateField('deployment.monitoring.alerts.response_time_threshold', parseFloat(e.target.value))}
              min="0"
              step="0.1"
            >
          </label>
          <label>
            Accuracy Threshold (0-1)
            <input 
              type="number" 
              value={currentCharacter?.deployment?.monitoring?.alerts?.accuracy_threshold || 0.85}
              on:input={(e) => updateField('deployment.monitoring.alerts.accuracy_threshold', parseFloat(e.target.value))}
              min="0"
              max="1"
              step="0.01"
            >
          </label>
        </div>

        <div class="form-group">
          <h3>Client Configuration</h3>
          <div class="checkbox-group">
            <label>
              <input 
                type="checkbox" 
                checked={currentCharacter?.clients?.includes('discord')}
                on:change={(e) => {
                  const clients = currentCharacter?.clients || [];
                  if (e.target.checked) {
                    clients.push('discord');
                  } else {
                    const index = clients.indexOf('discord');
                    if (index > -1) clients.splice(index, 1);
                  }
                  updateField('clients', [...new Set(clients)]);
                }}
              >
              Discord
            </label>
            <label>
              <input 
                type="checkbox" 
                checked={currentCharacter?.clients?.includes('twitter')}
                on:change={(e) => {
                  const clients = currentCharacter?.clients || [];
                  if (e.target.checked) {
                    clients.push('twitter');
                  } else {
                    const index = clients.indexOf('twitter');
                    if (index > -1) clients.splice(index, 1);
                  }
                  updateField('clients', [...new Set(clients)]);
                }}
              >
              Twitter
            </label>
            <label>
              <input 
                type="checkbox" 
                checked={currentCharacter?.clients?.includes('direct')}
                on:change={(e) => {
                  const clients = currentCharacter?.clients || [];
                  if (e.target.checked) {
                    clients.push('direct');
                  } else {
                    const index = clients.indexOf('direct');
                    if (index > -1) clients.splice(index, 1);
                  }
                  updateField('clients', [...new Set(clients)]);
                }}
              >
              Direct
            </label>
          </div>
        </div>
        <div class="form-group">
          <h3>Style Configuration</h3>
          <label>
            General Style Guidelines (one per line)
            <textarea
              value={currentCharacter?.style?.all?.join('\n') || ''}
              on:input={(e) => updateField('style.all', e.target.value.split('\n').filter(s => s.trim()))}
              rows="3"
              placeholder="Enter general style guidelines, one per line"
            ></textarea>
          </label>
          <label>
            Chat Style Guidelines (one per line)
            <textarea
              value={currentCharacter?.style?.chat?.join('\n') || ''}
              on:input={(e) => updateField('style.chat', e.target.value.split('\n').filter(s => s.trim()))}
              rows="3"
              placeholder="Enter chat-specific style guidelines, one per line"
            ></textarea>
          </label>
          <label>
            Post Style Guidelines (one per line)
            <textarea
              value={currentCharacter?.style?.post?.join('\n') || ''}
              on:input={(e) => updateField('style.post', e.target.value.split('\n').filter(s => s.trim()))}
              rows="3"
              placeholder="Enter post-specific style guidelines, one per line"
            ></textarea>
          </label>
        </div>
      </div>
    </div>

    <div class="preview-section" class:hidden={currentStep !== 'preview'}>
      <h2>Agent Preview</h2>
      <div class="preview-container">
        <div class="preview-card">
          <div class="preview-header">
            <h3>{currentCharacter?.name || 'Unnamed Agent'}</h3>
            <span class="preview-type">{currentCharacter?.type || 'No Type'}</span>
          </div>
          <p class="preview-description">{currentCharacter?.description || 'No description provided'}</p>
          
          <div class="preview-section">
            <h4>Model Configuration</h4>
            <div class="preview-details">
              <span>Provider: {currentCharacter?.modelProvider || 'Not set'}</span>
              <span>Model: {currentCharacter?.settings?.model || 'Not set'}</span>
            </div>
          </div>

          <div class="preview-section">
            <h4>Deployment</h4>
            <div class="preview-details">
              <span>Environment: {currentCharacter?.deployment?.environment || 'development'}</span>
              <span>Auto-start: {currentCharacter?.deployment?.autoStart ? 'Yes' : 'No'}</span>
              <span>Monitoring: {currentCharacter?.deployment?.monitoring?.enabled ? 'Enabled' : 'Disabled'}</span>
            </div>
          </div>

          <div class="preview-section">
            <h4>Schedule</h4>
            <div class="preview-details">
              <span>Active: {currentCharacter?.deployment?.schedule?.active ? 'Yes' : 'No'}</span>
              <span>Days: {currentCharacter?.deployment?.schedule?.availability?.[0]?.days?.join(', ') || 'Not set'}</span>
              <span>Hours: {currentCharacter?.deployment?.schedule?.availability?.[0]?.hours?.[0] || 'Not set'}</span>
            </div>
          </div>

          <div class="preview-section">
            <h4>Capabilities</h4>
            <div class="preview-capabilities">
              {#if currentCharacter?.capabilities?.analysis}
                <div class="capability-group">
                  <h5>Analysis</h5>
                  <ul>
                    {#each currentCharacter.capabilities.analysis as capability}
                      <li>{capability}</li>
                    {/each}
                  </ul>
                </div>
              {/if}
              {#if currentCharacter?.capabilities?.reporting}
                <div class="capability-group">
                  <h5>Reporting</h5>
                  <ul>
                    {#each currentCharacter.capabilities.reporting as capability}
                      <li>{capability}</li>
                    {/each}
                  </ul>
                </div>
              {/if}
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="editor-section" class:hidden={currentStep === 'training' || currentStep === 'capabilities' || currentStep === 'deployment' || currentStep === 'preview'}>
      <h2>Configuration JSON</h2>
      {#if loadError}
        <div class="error">{loadError}</div>
      {/if}
      <div class="editor-container">
        <textarea
          bind:value={jsonEditor}
          on:input={updateJson}
          placeholder="Paste or edit JSON here"
          spellcheck="false"
        ></textarea>
      </div>
    </div>
  </div>

  <div class="navigation">
    <button 
      class="secondary" 
      on:click={previousStep}
      disabled={currentStep === 'template'}>
      Previous
    </button>
    <button 
      class="primary" 
      on:click={nextStep}
      disabled={currentStep === 'preview'}>
      Next
    </button>
  </div>
</div>

<style>
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    font-family: system-ui, -apple-system, sans-serif;
  }

  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
  }

  h1 {
    color: #4f46e5;
    margin: 0;
  }

  h2 {
    color: #4f46e5;
    margin-bottom: 1rem;
  }

  .actions {
    display: flex;
    gap: 1rem;
  }

  button,
  .upload-btn {
    background: #4f46e5;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.2s;
  }

  button:hover,
  .upload-btn:hover {
    background: #4338ca;
  }

  .content {
    display: grid;
    grid-template-columns: 1fr;
    gap: 2rem;
  }

  .templates {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .template-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .template-card {
    background: #f8fafc;
    padding: 1rem;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s;
  }

  .template-card:hover {
    background: #f1f5f9;
    transform: translateY(-2px);
  }

  .template-card h3 {
    margin: 0 0 0.5rem 0;
    color: #1e293b;
  }

  .template-card p {
    margin: 0;
    color: #64748b;
    font-size: 0.9rem;
  }

  .editor-section {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .editor-container {
    position: relative;
    height: calc(100vh - 250px);
  }

  .editor-container textarea {
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', 'Consolas', monospace;
    background: #1e293b;
    color: #e2e8f0;
    resize: none;
  }

  textarea {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    font-family: system-ui, -apple-system, sans-serif;
    font-size: 0.9rem;
    line-height: 1.5;
    resize: vertical;
  }

  textarea:focus {
    outline: none;
    border-color: #4f46e5;
  }

  .error {
    color: #ef4444;
    margin-bottom: 1rem;
    padding: 0.5rem;
    background: #fef2f2;
    border-radius: 4px;
  }

  .steps {
    display: flex;
    justify-content: space-between;
    margin-bottom: 2rem;
    padding: 0 1rem;
  }

  .step {
    padding: 0.5rem 1rem;
    border-radius: 4px;
    background: #f1f5f9;
    color: #64748b;
  }

  .step.active {
    background: #4f46e5;
    color: white;
  }

  .hidden {
    display: none;
  }

  .training-form,
  .deployment-form {
    display: grid;
    gap: 1.5rem;
  }

  .form-group {
    background: #f8fafc;
    padding: 1.5rem;
    border-radius: 4px;
  }

  .form-group h3 {
    margin: 0 0 1rem 0;
    color: #1e293b;
  }

  .checkbox-group {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
  }

  .checkbox-label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
  }

  .schedule-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    gap: 0.5rem;
    margin: 1rem 0;
  }

  .preview-container {
    background: white;
    padding: 1.5rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  .preview-card {
    background: #f8fafc;
    padding: 1.5rem;
    border-radius: 6px;
  }

  .preview-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .preview-header h3 {
    margin: 0;
    color: #1e293b;
  }

  .preview-type {
    background: #e2e8f0;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.875rem;
    color: #475569;
  }

  .preview-description {
    color: #64748b;
    margin-bottom: 1.5rem;
  }

  .preview-section {
    margin-bottom: 1.5rem;
  }

  .preview-section h4 {
    color: #1e293b;
    margin: 0 0 0.5rem 0;
    font-size: 1rem;
  }

  .preview-details {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    color: #64748b;
    font-size: 0.875rem;
  }

  .preview-capabilities {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
  }

  .capability-group h5 {
    color: #1e293b;
    margin: 0 0 0.5rem 0;
    font-size: 0.875rem;
  }

  .capability-group ul {
    list-style: none;
    padding: 0;
    margin: 0;
    color: #64748b;
    font-size: 0.875rem;
  }

  .capability-group li {
    margin-bottom: 0.25rem;
  }

  .checkbox-group input[type="checkbox"] {
    width: auto;
    margin: 0;
  }

  label {
    display: block;
    margin-bottom: 1rem;
  }

  label input,
  label select {
    display: block;
    width: 100%;
    margin-top: 0.5rem;
    padding: 0.5rem;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
  }

  .navigation {
    display: flex;
    justify-content: space-between;
    margin-top: 2rem;
    padding: 1rem;
    background: white;
    border-top: 1px solid #e2e8f0;
  }

  .secondary {
    background: #64748b;
  }

  .secondary:hover {
    background: #475569;
  }

  button:disabled {
    background: #cbd5e1;
    cursor: not-allowed;
  }

  @media (max-width: 768px) {
    .steps {
      flex-direction: column;
      gap: 0.5rem;
    }
  }
</style>
