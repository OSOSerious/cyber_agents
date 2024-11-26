<script>
  import { onMount } from 'svelte';
  import { theme } from '../stores/theme.js';
  import ContactChatbot from './ContactChatbot.svelte';

  let pipelineStages = [
    { name: 'Lead', contacts: [] },
    { name: 'Qualified', contacts: [] },
    { name: 'Proposal', contacts: [] },
    { name: 'Negotiation', contacts: [] },
    { name: 'Closed Won', contacts: [] }
  ];

  let contacts = [
    { id: 1, name: 'Alice Johnson', company: 'TechCorp', email: 'alice@techcorp.com', phone: '123-456-7890', value: 5000, stage: 'Lead' },
    { id: 2, name: 'Bob Smith', company: 'DesignHub', email: 'bob@designhub.com', phone: '234-567-8901', value: 10000, stage: 'Qualified' },
    { id: 3, name: 'Carol Williams', company: 'MarketPro', email: 'carol@marketpro.com', phone: '345-678-9012', value: 15000, stage: 'Proposal' },
    { id: 4, name: 'David Brown', company: 'InfoSoft', email: 'david@infosoft.com', phone: '456-789-0123', value: 20000, stage: 'Negotiation' },
    { id: 5, name: 'Eva Davis', company: 'GrowthCo', email: 'eva@growthco.com', phone: '567-890-1234', value: 25000, stage: 'Closed Won' }
  ];

  let newContact = {
    name: '',
    company: '',
    email: '',
    phone: '',
    value: 0,
    stage: 'Lead'
  };

  let editingContact = null;
  let selectedContact = null;
  let chatbotOpen = false;

  function distributeContacts() {
    pipelineStages.forEach(stage => {
      stage.contacts = contacts.filter(contact => contact.stage === stage.name);
    });
    pipelineStages = pipelineStages;
  }

  function moveContact(contact, direction) {
    const currentIndex = pipelineStages.findIndex(stage => stage.name === contact.stage);
    const newIndex = currentIndex + direction;

    if (newIndex >= 0 && newIndex < pipelineStages.length) {
      contact.stage = pipelineStages[newIndex].name;
      distributeContacts();
    }
  }

  function addContact() {
    if (newContact.name && newContact.company) {
      contacts = [...contacts, { ...newContact, id: contacts.length + 1 }];
      newContact = { name: '', company: '', email: '', phone: '', value: 0, stage: 'Lead' };
      distributeContacts();
    }
  }

  function startEditing(contact) {
    editingContact = { ...contact };
  }

  function saveEdit() {
    const index = contacts.findIndex(c => c.id === editingContact.id);
    if (index !== -1) {
      contacts[index] = editingContact;
      contacts = contacts;
      distributeContacts();
    }
    editingContact = null;
  }

  function cancelEdit() {
    editingContact = null;
  }

  function deleteContact(contact) {
    contacts = contacts.filter(c => c.id !== contact.id);
    distributeContacts();
  }

  function selectContact(contact) {
    selectedContact = contact;
  }

  function closePopup() {
    selectedContact = null;
  }

  function toggleChatbot() {
    chatbotOpen = !chatbotOpen;
  }

  onMount(() => {
    distributeContacts();
  });
</script>

<div class="pipeline" class:dark={$theme === 'dark'}>
  <h1>Sales Pipeline</h1>
  
  <div class="add-contact">
    <h2>Add New Contact</h2>
    <input bind:value={newContact.name} placeholder="Name" />
    <input bind:value={newContact.company} placeholder="Company" />
    <input bind:value={newContact.email} placeholder="Email" type="email" />
    <input bind:value={newContact.phone} placeholder="Phone" type="tel" />
    <input bind:value={newContact.value} placeholder="Deal Value" type="number" />
    <select bind:value={newContact.stage}>
      {#each pipelineStages as stage}
        <option value={stage.name}>{stage.name}</option>
      {/each}
    </select>
    <button on:click={addContact}>Add Contact</button>
  </div>

  <div class="pipeline-board">
    {#each pipelineStages as stage}
      <div class="pipeline-stage">
        <h2>{stage.name}</h2>
        {#each stage.contacts as contact (contact.id)}
          <div class="contact-card" on:click={() => selectContact(contact)}>
            {#if editingContact && editingContact.id === contact.id}
              <input bind:value={editingContact.name} placeholder="Name" />
              <input bind:value={editingContact.company} placeholder="Company" />
              <input bind:value={editingContact.email} placeholder="Email" type="email" />
              <input bind:value={editingContact.phone} placeholder="Phone" type="tel" />
              <input bind:value={editingContact.value} placeholder="Deal Value" type="number" />
              <div class="card-actions">
                <button on:click={saveEdit}>Save</button>
                <button on:click={cancelEdit}>Cancel</button>
              </div>
            {:else}
              <h3>{contact.name}</h3>
              <p>{contact.company}</p>
              <p>{contact.email}</p>
              <p>{contact.phone}</p>
              <p>${contact.value.toLocaleString()}</p>
              <div class="card-actions">
                <button on:click={() => moveContact(contact, -1)} disabled={stage.name === 'Lead'}>←</button>
                <button on:click={() => startEditing(contact)}>Edit</button>
                <button on:click={() => deleteContact(contact)}>Delete</button>
                <button on:click={() => moveContact(contact, 1)} disabled={stage.name === 'Closed Won'}>→</button>
              </div>
            {/if}
          </div>
        {/each}
      </div>
    {/each}
  </div>

  {#if selectedContact}
    <div class="popup-background" on:click={closePopup}></div>
    <div class="popup">
      <h2>{selectedContact.name}</h2>
      <p><strong>Company:</strong> {selectedContact.company}</p>
      <p><strong>Email:</strong> {selectedContact.email}</p>  
      <p><strong>Phone:</strong> {selectedContact.phone}</p>
      <p><strong>Deal Value:</strong> ${selectedContact.value.toLocaleString()}</p>
      <p><strong>Stage:</strong> {selectedContact.stage}</p>
      
      <button on:click={toggleChatbot}>{chatbotOpen ? 'Close Chatbot' : 'Open Chatbot'}</button>
      <button on:click={closePopup}>Close</button>
    </div>
  {/if}

  {#if chatbotOpen}
    <ContactChatbot contact={selectedContact} />  
  {/if}
</div>

<section>
  <h2>Creating a Real-Time, Personalized Experience</h2>
  <p>Contacting.AI’s AI agents and human POCs provide personalized interactions, learning from customer behavior to create meaningful engagement at every touchpoint.</p>
</section>

<style>
  .pipeline {
    padding: 20px;
  }

  .add-contact {
    margin-bottom: 20px;
  }

  .add-contact input, .add-contact select {
    margin-right: 10px;
    margin-bottom: 10px;
    padding: 5px;
  }

  .pipeline-board {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    overflow-x: auto;
  }

  .pipeline-stage {
    flex: 1;
    min-width: 250px;
    background-color: #f0f0f0;
    border-radius: 5px;
    padding: 10px;
  }

  .contact-card {
    background-color: white;
    border-radius: 5px;
    padding: 10px;
    margin-bottom: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    cursor: pointer;
  }

  .card-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
  }

  button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 2px 2px;
    cursor: pointer;
    border-radius: 3px;
  }

  button:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
  }

  h1, h2, h3 {
    margin: 0 0 10px 0;
  }

  p {
    margin: 5px 0;
  }

  .dark {
    background-color: #1a1a1a;
    color: #f0f0f0;
  }

  .dark .pipeline-stage {
    background-color: #2c3e50;
  }

  .dark .contact-card {
    background-color: #34495e;
    color: #ecf0f1;
  }

  .dark button {
    background-color: #2980b9;
  }

  .dark button:disabled {
    background-color: #7f8c8d;
  }

  .dark input, .dark select {
    background-color: #2c3e50;
    color: #ecf0f1;
    border: 1px solid #34495e;
  }

  .popup-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 100;
  }

  .popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    z-index: 101;
    max-width: 400px;
  }

  .dark .popup {
    background-color: #34495e;
    color: #ecf0f1;
  }
</style>
