<script>
  import { fade } from 'svelte/transition';
  import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher();

  export let campaign = {
    name: '',
    category: '',
    tags: [],
    subject: '',
    content: '',
    targetAudience: '',
    schedule: 'immediate',
    scheduledDate: ''
  };

  const categories = ['B2B', 'B2C', 'Enterprise', 'Startup', 'E-commerce'];
  const availableTags = ['Cold Email', 'Follow-up', 'Newsletter', 'Promotion', 'Onboarding'];

  let selectedTag = '';
  let error = '';

  function addTag() {
    if (selectedTag && !campaign.tags.includes(selectedTag)) {
      campaign.tags = [...campaign.tags, selectedTag];
      selectedTag = '';
    }
  }

  function removeTag(tag) {
    campaign.tags = campaign.tags.filter(t => t !== tag);
  }

  function handleSubmit() {
    if (!campaign.name || !campaign.category || !campaign.subject || !campaign.content) {
      error = 'Please fill in all required fields';
      return;
    }

    dispatch('save', { campaign });
  }
</script>

<div class="campaign-editor" in:fade>
  <div class="editor-header">
    <h2>{campaign.id ? 'Edit Campaign' : 'Create New Campaign'}</h2>
  </div>

  <form on:submit|preventDefault={handleSubmit} class="editor-form">
    <div class="form-grid">
      <div class="form-group">
        <label for="name">Campaign Name *</label>
        <input
          type="text"
          id="name"
          bind:value={campaign.name}
          placeholder="Enter campaign name"
          required
        />
      </div>

      <div class="form-group">
        <label for="category">Category *</label>
        <select id="category" bind:value={campaign.category} required>
          <option value="">Select a category</option>
          {#each categories as category}
            <option value={category}>{category}</option>
          {/each}
        </select>
      </div>

      <div class="form-group">
        <label>Tags</label>
        <div class="tags-input">
          <select bind:value={selectedTag}>
            <option value="">Select a tag</option>
            {#each availableTags as tag}
              <option value={tag}>{tag}</option>
            {/each}
          </select>
          <button type="button" class="add-tag-btn" on:click={addTag}>Add</button>
        </div>
        <div class="tags-display">
          {#each campaign.tags as tag}
            <span class="tag">
              {tag}
              <button type="button" class="remove-tag" on:click={() => removeTag(tag)}>×</button>
            </span>
          {/each}
        </div>
      </div>

      <div class="form-group">
        <label for="targetAudience">Target Audience</label>
        <textarea
          id="targetAudience"
          bind:value={campaign.targetAudience}
          placeholder="Describe your target audience"
          rows="3"
        ></textarea>
      </div>

      <div class="form-group full-width">
        <label for="subject">Email Subject *</label>
        <input
          type="text"
          id="subject"
          bind:value={campaign.subject}
          placeholder="Enter email subject"
          required
        />
      </div>

      <div class="form-group full-width">
        <label for="content">Email Content *</label>
        <textarea
          id="content"
          bind:value={campaign.content}
          placeholder="Enter your email content"
          rows="6"
          required
        ></textarea>
      </div>

      <div class="form-group">
        <label for="schedule">Schedule</label>
        <select id="schedule" bind:value={campaign.schedule}>
          <option value="immediate">Send Immediately</option>
          <option value="scheduled">Schedule for Later</option>
        </select>
      </div>

      {#if campaign.schedule === 'scheduled'}
        <div class="form-group">
          <label for="scheduledDate">Schedule Date</label>
          <input
            type="datetime-local"
            id="scheduledDate"
            bind:value={campaign.scheduledDate}
          />
        </div>
      {/if}
    </div>

    {#if error}
      <div class="error-message">{error}</div>
    {/if}

    <div class="form-actions">
      <button type="button" class="cancel-btn" on:click={() => dispatch('cancel')}>
        Cancel
      </button>
      <button type="submit" class="save-btn">
        {campaign.id ? 'Update Campaign' : 'Create Campaign'}
      </button>
    </div>
  </form>
</div>

<style>
  .campaign-editor {
    background: white;
    border-radius: 0.75rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    padding: 2rem;
  }

  .editor-header {
    margin-bottom: 2rem;
  }

  .editor-header h2 {
    color: #1a1a1a;
    font-size: 1.5rem;
  }

  .editor-form {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .form-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .form-group.full-width {
    grid-column: 1 / -1;
  }

  label {
    color: #444;
    font-weight: 500;
  }

  input,
  select,
  textarea {
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 0.5rem;
    font-size: 1rem;
    transition: border-color 0.2s;
  }

  input:focus,
  select:focus,
  textarea:focus {
    border-color: #4a90e2;
    outline: none;
  }

  .tags-input {
    display: flex;
    gap: 0.5rem;
  }

  .tags-input select {
    flex: 1;
  }

  .add-tag-btn {
    padding: 0.75rem 1.5rem;
    background: #4a90e2;
    color: white;
    border: none;
    border-radius: 0.5rem;
    cursor: pointer;
    font-weight: 500;
  }

  .tags-display {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-top: 0.5rem;
  }

  .tag {
    background: #e3f2fd;
    color: #1976d2;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    display: flex;
    align-items: center;
    gap: 0.25rem;
  }

  .remove-tag {
    background: none;
    border: none;
    color: #1976d2;
    cursor: pointer;
    padding: 0;
    font-size: 1.2rem;
    line-height: 1;
  }

  .error-message {
    color: #e74c3c;
    text-align: center;
    font-size: 0.9rem;
  }

  .form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
  }

  .cancel-btn,
  .save-btn {
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .cancel-btn {
    background: #f5f5f5;
    border: 1px solid #ddd;
    color: #666;
  }

  .save-btn {
    background: #4a90e2;
    border: none;
    color: white;
  }

  .cancel-btn:hover {
    background: #eee;
  }

  .save-btn:hover {
    background: #357abd;
  }
</style>
