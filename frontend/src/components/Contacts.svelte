<script>
  import { onMount } from 'svelte';
  import ContactChatbot from './ContactChatbot.svelte';

  let contacts = [
    { id: 1, name: 'Alice Johnson', company: 'TechCorp', email: 'alice@techcorp.com', phone: '123-456-7890', value: 5000 },
    { id: 2, name: 'Bob Smith', company: 'DesignHub', email: 'bob@designhub.com', phone: '234-567-8901', value: 10000 },
    { id: 3, name: 'Carol Williams', company: 'MarketPro', email: 'carol@marketpro.com', phone: '345-678-9012', value: 15000 },
    { id: 4, name: 'David Brown', company: 'InfoSoft', email: 'david@infosoft.com', phone: '456-789-0123', value: 20000 },
    { id: 5, name: 'Eva Davis', company: 'GrowthCo', email: 'eva@growthco.com', phone: '567-890-1234', value: 25000 }
  ];

  let selectedContact = null;
  let chatbotOpen = false;

  function selectContact(contact) {
    selectedContact = contact;
  }

  function closePopup() {
    selectedContact = null;
    chatbotOpen = false;
  }

  function toggleChatbot() {
    chatbotOpen = !chatbotOpen;
  }

  onMount(() => {
    // TODO: Fetch contacts from API
  });
</script>

<main>
  <h1>Contacts</h1>

  <section>
    <h2>Introducing Contacting.AI</h2>
    <h3>AI-Powered, Real-Time Customer Communication Platform</h3>
    <p>Contacting.AI redefines customer engagement by eliminating email communication and replacing it with instant, human or AI-powered touchpoints, maximizing conversions and engagement.</p>
  </section>

  <section>
    <h2>Our Mission</h2>
    <p>To revolutionize customer communication by replacing email-based contact with real-time, personalized interactions through AI and human agents, driving higher engagement and conversion rates.</p>
  </section>

  <section>
    <h2>Challenges with Traditional Email Communication</h2>
    <ul>
      <li>Email outreach results in low engagement and high abandonment rates.</li>
      <li>Delayed responses reduce customer satisfaction and conversion potential.</li>
      <li>Limited personalization in email lacks the human touch customers expect.</li>
    </ul>
    <p>Current customer communication methods are too dependent on email, lacking immediacy and personalization.</p>
  </section>

  <section>
    <h2>Contacting.AI: The Future of Customer Engagement</h2>
    <p>Contacting.AI eliminates email as a point of contact, offering businesses a real-time, personalized experience for each customer. Through human and AI agents, the platform replaces traditional emails with direct, impactful communication.</p>
  </section>

  <section>
    <h2>Transformative Platform Features</h2>
    <ul>
      <li>Instant POC (Point of Contact): AI or human agents connect with customers in real time, responding to interest and intent immediately.</li>
      <li>Omni-Channel Strategy: Customers are engaged through voice, chat, and SMS — no emails.</li>
      <li>Automated Follow-Ups with Real-Time Agents: AI or human agents follow up instantly, increasing conversion rates.</li>
      <li>Personalized Interactions: Every contact is tailored based on customer behavior and preferences.</li>
    </ul>
  </section>

  <section>
    <h2>Leveraging AI for Real-Time Customer Engagement</h2>
    <p>Contacting.AI’s advanced AI agents provide responsive, human-like interactions in real time, understanding customer needs and responding to intent immediately, without any delay or reliance on email.</p>
  </section>

  <section>
    <h2>Engaging Customers Through Their Preferred Medium</h2>
    <p>Contacting.AI allows businesses to connect with customers through channels like chat, voice, and SMS — completely removing email from the communication funnel and offering a more dynamic customer experience.</p>
  </section>

  <section>
    <h2>Boosting Productivity by Removing Email Dependency</h2>
    <p>By eliminating the need for email campaigns and inbox management, Contacting.AI frees up businesses to focus on live, impactful interactions that directly convert customers.</p>
  </section>

  <section>
    <h2>Creating a Real-Time, Personalized Experience</h2>
    <p>Contacting.AI’s AI agents and human POCs provide personalized interactions, learning from customer behavior to create meaningful engagement at every touchpoint.</p>
  </section>

  <section>
    <h2>Converting Traffic into Revenue Without Email Dependency</h2>
    <p>Contacting.AI maximizes revenue potential by converting traffic into immediate POCs, reducing delays and improving conversion rates.</p>
  </section>

  <section>
    <h2>Real-Time, High-Conversion Point of Contact</h2>
    <p>Contacting.AI turns every customer touchpoint into an immediate opportunity for engagement, eliminating the need for delayed email communication and maximizing conversion rates.</p>
  </section>

  <section>
    <h2>Blending AI and Human Touch for Optimal Engagement</h2>
    <p>Customers can connect instantly with either an AI agent or a human representative, ensuring each interaction is as impactful and personalized as possible.</p>
  </section>

  <section>
    <h2>Real-Time Performance Tracking and Optimization</h2>
    <p>Contacting.AI offers real-time analytics on interaction performance, tracking conversions, engagement time, and customer satisfaction without the limitations of email open or click rates.</p>
  </section>

  <section>
    <h2>Contacting.AI: Revolutionizing Customer Communication</h2>
    <p>By eliminating email as a primary channel, Contacting.AI offers a comprehensive platform that leverages AI and human agents to deliver real-time, impactful communication, transforming every interaction into a high-conversion POC.</p>
  </section>

  <div class="contacts-list">
    {#each contacts as contact (contact.id)}
      <div class="contact-card" on:click={() => selectContact(contact)}>
        <h3>{contact.name}</h3>
        <p>{contact.company}</p>
        <p>{contact.email}</p>
        <p>{contact.phone}</p>
        <p>${contact.value.toLocaleString()}</p>
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
      
      <button on:click={toggleChatbot}>{chatbotOpen ? 'Close Chatbot' : 'Open Chatbot'}</button>
      <button on:click={closePopup}>Close</button>
    </div>
  {/if}

  {#if chatbotOpen && selectedContact}
    <ContactChatbot contact={selectedContact} />  
  {/if}
</main>

<style>
  main {
    padding: 20px;
  }

  .contacts-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
  }

  .contact-card {
    background-color: #f0f0f0;
    border-radius: 5px;
    padding: 10px;
    cursor: pointer;
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

  button {
    margin-top: 10px;
    padding: 5px 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 3px;
  }

  button:hover {
    background-color: #45a049;
  }
</style>
