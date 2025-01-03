<script>
  import { onMount } from 'svelte';

  let files = [];
  let uploadError = '';
  let processingStatus = '';
  let documentStore = [];

  function handleFileUpload(event) {
    const uploadedFiles = Array.from(event.target.files);
    files = [...files, ...uploadedFiles];
  }

  async function processFiles() {
    processingStatus = 'Processing documents...';
    try {
      // Here we would integrate with the document processing system
      // For now, just simulate processing
      for (const file of files) {
        documentStore.push({
          name: file.name,
          type: file.type,
          size: file.size,
          status: 'processed',
          timestamp: new Date().toISOString()
        });
      }
      documentStore = documentStore; // Trigger reactivity
      files = [];
      processingStatus = 'Documents processed successfully';
    } catch (error) {
      uploadError = `Failed to process documents: ${error.message}`;
    }
  }

  function removeDocument(index) {
    documentStore = documentStore.filter((_, i) => i !== index);
  }
</script>

<div class="document-manager">
  <h2>Document Management</h2>
  
  <div class="upload-section">
    <div class="upload-area" 
      on:dragover|preventDefault 
      on:drop|preventDefault={(e) => {
        files = [...files, ...Array.from(e.dataTransfer.files)];
      }}>
      <label class="upload-label">
        <input 
          type="file" 
          multiple 
          accept=".pdf,.doc,.docx,.txt,.json"
          on:change={handleFileUpload}
          style="display: none;"
        >
        <div class="upload-icon">📄</div>
        <p>Drop files here or click to upload</p>
        <p class="upload-hint">Supports PDF, DOC, DOCX, TXT, JSON</p>
      </label>
    </div>

    {#if files.length > 0}
      <div class="queued-files">
        <h3>Files to Process</h3>
        <ul>
          {#each files as file}
            <li>
              <span>{file.name}</span>
              <button class="remove-btn" on:click={() => files = files.filter(f => f !== file)}>✕</button>
            </li>
          {/each}
        </ul>
        <button class="process-btn" on:click={processFiles}>Process Files</button>
      </div>
    {/if}

    {#if uploadError}
      <div class="error">{uploadError}</div>
    {/if}

    {#if processingStatus}
      <div class="status">{processingStatus}</div>
    {/if}
  </div>

  <div class="document-store">
    <h3>Document Store</h3>
    {#if documentStore.length === 0}
      <p class="empty-state">No documents in store</p>
    {:else}
      <div class="document-list">
        {#each documentStore as doc, i}
          <div class="document-item">
            <div class="document-info">
              <span class="document-name">{doc.name}</span>
              <span class="document-meta">
                {new Date(doc.timestamp).toLocaleDateString()} • 
                {Math.round(doc.size / 1024)}KB
              </span>
            </div>
            <button class="remove-btn" on:click={() => removeDocument(i)}>Remove</button>
          </div>
        {/each}
      </div>
    {/if}
  </div>
</div>

<style>
  .document-manager {
    padding: 2rem;
    background: white;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  }

  h2 {
    color: #4f46e5;
    margin: 0 0 1.5rem;
  }

  .upload-section {
    margin-bottom: 2rem;
  }

  .upload-area {
    border: 2px dashed #e2e8f0;
    border-radius: 8px;
    padding: 2rem;
    text-align: center;
    transition: all 0.2s;
  }

  .upload-area:hover {
    border-color: #4f46e5;
    background: #f8fafc;
  }

  .upload-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
  }

  .upload-label {
    cursor: pointer;
  }

  .upload-hint {
    color: #64748b;
    font-size: 0.9rem;
    margin-top: 0.5rem;
  }

  .queued-files {
    margin-top: 1.5rem;
    padding: 1rem;
    background: #f8fafc;
    border-radius: 8px;
  }

  .queued-files ul {
    list-style: none;
    padding: 0;
    margin: 1rem 0;
  }

  .queued-files li {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem;
    background: white;
    margin-bottom: 0.5rem;
    border-radius: 4px;
  }

  .process-btn {
    background: #4f46e5;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .process-btn:hover {
    background: #4338ca;
  }

  .remove-btn {
    background: none;
    border: none;
    color: #ef4444;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
  }

  .remove-btn:hover {
    background: #fee2e2;
  }

  .error {
    color: #ef4444;
    padding: 0.5rem;
    margin-top: 1rem;
    background: #fef2f2;
    border-radius: 4px;
  }

  .status {
    color: #4f46e5;
    padding: 0.5rem;
    margin-top: 1rem;
    background: #eef2ff;
    border-radius: 4px;
  }

  .document-store {
    margin-top: 2rem;
  }

  .empty-state {
    text-align: center;
    color: #64748b;
    padding: 2rem;
    background: #f8fafc;
    border-radius: 8px;
  }

  .document-list {
    display: grid;
    gap: 1rem;
  }

  .document-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    background: #f8fafc;
    border-radius: 8px;
  }

  .document-info {
    display: flex;
    flex-direction: column;
  }

  .document-name {
    font-weight: 500;
    color: #1e293b;
  }

  .document-meta {
    font-size: 0.9rem;
    color: #64748b;
    margin-top: 0.25rem;
  }
</style>
