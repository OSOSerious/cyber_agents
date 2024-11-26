<script>
  let template = {
    name: '',
    subject: '',
    content: ''
  };

  let personalizationFields = ['{{name}}', '{{company}}', '{{custom_field}}'];

  function insertField(field) {
    template.content += field;
  }

  function saveTemplate() {
    // Placeholder for actual save functionality
    console.log('Saving template:', template);
    alert('Template saved!');
  }
</script>

<div class="email-template-editor">
  <h1>Email Template Editor</h1>
  
  <div class="template-form">
    <input bind:value={template.name} placeholder="Template Name" />
    <input bind:value={template.subject} placeholder="Email Subject" />
    <textarea bind:value={template.content} placeholder="Email Content"></textarea>
    
    <div class="personalization-fields">
      <h3>Personalization Fields</h3>
      {#each personalizationFields as field}
        <button on:click={() => insertField(field)}>{field}</button>
      {/each}
    </div>
    
    <button on:click={saveTemplate}>Save Template</button>
  </div>

  <div class="preview">
    <h2>Preview</h2>
    <div class="email-preview">
      <h3>{template.subject}</h3>
      <p>{@html template.content.replace(/\n/g, '<br>')}</p>
    </div>
  </div>
</div>

<style>
  .email-template-editor {
    padding: 20px;
    display: flex;
    gap: 20px;
  }

  .template-form {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .template-form input, .template-form textarea {
    padding: 5px;
  }

  .personalization-fields {
    margin-top: 10px;
  }

  .personalization-fields button {
    margin-right: 5px;
    margin-bottom: 5px;
  }

  .preview {
    flex: 1;
  }

  .email-preview {
    background-color: #f0f0f0;
    padding: 15px;
    border-radius: 5px;
  }
</style>