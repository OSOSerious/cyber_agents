<script>
  let sequence = [];
  let newEmail = { subject: '', content: '', delay: 1 };

  function addEmail() {
    sequence = [...sequence, { ...newEmail }];
    newEmail = { subject: '', content: '', delay: 1 };
  }

  function removeEmail(index) {
    sequence = sequence.filter((_, i) => i !== index);
  }
</script>

<div class="email-sequence-creator">
  <h1>Email Sequence Creator</h1>
  
  <div class="new-email">
    <input bind:value={newEmail.subject} placeholder="Email Subject" />
    <textarea bind:value={newEmail.content} placeholder="Email Content"></textarea>
    <input type="number" bind:value={newEmail.delay} min="1" placeholder="Delay (days)" />
    <button on:click={addEmail}>Add Email to Sequence</button>
  </div>

  <div class="sequence">
    {#each sequence as email, index}
      <div class="email-item">
        <h3>Email {index + 1}</h3>
        <p><strong>Subject:</strong> {email.subject}</p>
        <p><strong>Content:</strong> {email.content}</p>
        <p><strong>Delay:</strong> {email.delay} day(s)</p>
        <button on:click={() => removeEmail(index)}>Remove</button>
      </div>
    {/each}
  </div>
</div>

<style>
  .email-sequence-creator {
    padding: 20px;
  }

  .new-email {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-bottom: 20px;
  }

  .new-email input, .new-email textarea {
    padding: 5px;
  }

  .sequence {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .email-item {
    background-color: #f0f0f0;
    padding: 15px;
    border-radius: 5px;
  }
</style>