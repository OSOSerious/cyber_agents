<script>
  import { fade } from 'svelte/transition';
  import DashboardLayout from '../components/DashboardLayout.svelte';

  // Sample data - replace with actual API calls
  let conversations = [
    {
      id: 1,
      customer: {
        name: 'John Smith',
        email: 'john.smith@example.com',
        avatar: '/default-avatar.png'
      },
      lastMessage: 'I need help with setting up my account',
      time: '5 min ago',
      status: 'active',
      unread: 2
    },
    {
      id: 2,
      customer: {
        name: 'Sarah Johnson',
        email: 'sarah.j@example.com',
        avatar: '/default-avatar.png'
      },
      lastMessage: 'Thanks for your help with the technical issue',
      time: '15 min ago',
      status: 'completed',
      unread: 0
    },
    {
      id: 3,
      customer: {
        name: 'Mike Wilson',
        email: 'mike.w@example.com',
        avatar: '/default-avatar.png'
      },
      lastMessage: 'Can you explain the pricing plans?',
      time: '1 hour ago',
      status: 'pending',
      unread: 1
    }
  ];

  let selectedConversation = null;
  let newMessage = '';

  function handleSendMessage() {
    if (!newMessage.trim()) return;
    
    // Add message to conversation
    // This is a placeholder - replace with actual API call
    const message = {
      id: Date.now(),
      content: newMessage,
      sender: 'agent',
      time: new Date().toISOString()
    };
    
    // Reset input
    newMessage = '';
  }

  let filterStatus = 'all';
  let searchQuery = '';

  $: filteredConversations = conversations.filter(conv => {
    const matchesStatus = filterStatus === 'all' || conv.status === filterStatus;
    const matchesSearch = !searchQuery || 
      conv.customer.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      conv.customer.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
      conv.lastMessage.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesStatus && matchesSearch;
  });
</script>

<DashboardLayout>
  <div class="conversations-page" in:fade>
    <header class="page-header">
      <div class="header-content">
        <h1>Conversations</h1>
        <button class="new-conversation-btn">
          <span>+</span>
          New Conversation
        </button>
      </div>

      <div class="filters">
        <div class="search-box">
          <span class="search-icon">🔍</span>
          <input
            type="text"
            bind:value={searchQuery}
            placeholder="Search conversations..."
          />
        </div>

        <div class="status-filters">
          <button
            class="filter-btn"
            class:active={filterStatus === 'all'}
            on:click={() => filterStatus = 'all'}
          >
            All
          </button>
          <button
            class="filter-btn"
            class:active={filterStatus === 'active'}
            on:click={() => filterStatus = 'active'}
          >
            Active
          </button>
          <button
            class="filter-btn"
            class:active={filterStatus === 'pending'}
            on:click={() => filterStatus = 'pending'}
          >
            Pending
          </button>
          <button
            class="filter-btn"
            class:active={filterStatus === 'completed'}
            on:click={() => filterStatus = 'completed'}
          >
            Completed
          </button>
        </div>
      </div>
    </header>

    <div class="conversations-container">
      <div class="conversations-list">
        {#each filteredConversations as conversation (conversation.id)}
          <div
            class="conversation-card"
            class:active={selectedConversation?.id === conversation.id}
            on:click={() => selectedConversation = conversation}
          >
            <img
              src={conversation.customer.avatar}
              alt={conversation.customer.name}
              class="customer-avatar"
            />
            <div class="conversation-info">
              <div class="conversation-header">
                <h3 class="customer-name">{conversation.customer.name}</h3>
                <span class="conversation-time">{conversation.time}</span>
              </div>
              <div class="conversation-preview">
                <p class="last-message">{conversation.lastMessage}</p>
                {#if conversation.unread}
                  <span class="unread-badge">{conversation.unread}</span>
                {/if}
              </div>
              <span
                class="status-badge"
                class:active={conversation.status === 'active'}
                class:completed={conversation.status === 'completed'}
                class:pending={conversation.status === 'pending'}
              >
                {conversation.status}
              </span>
            </div>
          </div>
        {/each}
      </div>

      <div class="conversation-detail">
        {#if selectedConversation}
          <div class="detail-header">
            <div class="customer-info">
              <img
                src={selectedConversation.customer.avatar}
                alt={selectedConversation.customer.name}
                class="customer-avatar"
              />
              <div>
                <h2>{selectedConversation.customer.name}</h2>
                <p class="customer-email">{selectedConversation.customer.email}</p>
              </div>
            </div>
            <div class="detail-actions">
              <button class="action-btn">
                <span>📞</span>
                Call
              </button>
              <button class="action-btn">
                <span>📧</span>
                Email
              </button>
              <button class="action-btn">
                <span>⚙️</span>
              </button>
            </div>
          </div>

          <div class="messages-container">
            <!-- Messages will be displayed here -->
            <div class="message-placeholder">
              Messages will appear here
            </div>
          </div>

          <div class="message-input">
            <input
              type="text"
              bind:value={newMessage}
              placeholder="Type your message..."
              on:keydown={e => e.key === 'Enter' && handleSendMessage()}
            />
            <button
              class="send-btn"
              on:click={handleSendMessage}
              disabled={!newMessage.trim()}
            >
              Send
            </button>
          </div>
        {:else}
          <div class="no-conversation">
            <div class="placeholder-content">
              <span class="placeholder-icon">💬</span>
              <h2>Select a Conversation</h2>
              <p>Choose a conversation from the list to view messages</p>
            </div>
          </div>
        {/if}
      </div>
    </div>
  </div>
</DashboardLayout>

<style>
  .conversations-page {
    padding: 2rem;
    height: 100%;
    display: flex;
    flex-direction: column;
  }

  .page-header {
    margin-bottom: 2rem;
  }

  .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
  }

  .header-content h1 {
    font-size: 2rem;
    color: #1a1a1a;
  }

  .new-conversation-btn {
    background: #4a90e2;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    font-weight: 500;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    transition: background-color 0.2s;
  }

  .new-conversation-btn:hover {
    background: #357abd;
  }

  .filters {
    display: flex;
    gap: 1.5rem;
    align-items: center;
  }

  .search-box {
    flex: 1;
    max-width: 400px;
    position: relative;
  }

  .search-icon {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: #666;
  }

  .search-box input {
    width: 100%;
    padding: 0.75rem 1rem 0.75rem 2.5rem;
    border: 1px solid #eee;
    border-radius: 0.5rem;
    font-size: 0.9rem;
  }

  .status-filters {
    display: flex;
    gap: 0.5rem;
  }

  .filter-btn {
    background: none;
    border: 1px solid #eee;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    color: #666;
    cursor: pointer;
    transition: all 0.2s;
  }

  .filter-btn:hover {
    background: #f5f7fa;
  }

  .filter-btn.active {
    background: #4a90e2;
    color: white;
    border-color: #4a90e2;
  }

  .conversations-container {
    display: grid;
    grid-template-columns: 350px 1fr;
    gap: 2rem;
    height: calc(100vh - 200px);
    background: white;
    border-radius: 1rem;
    overflow: hidden;
  }

  .conversations-list {
    border-right: 1px solid #eee;
    overflow-y: auto;
  }

  .conversation-card {
    display: flex;
    gap: 1rem;
    padding: 1rem;
    cursor: pointer;
    transition: background-color 0.2s;
    border-bottom: 1px solid #eee;
  }

  .conversation-card:hover {
    background: #f5f7fa;
  }

  .conversation-card.active {
    background: #f0f7ff;
  }

  .customer-avatar {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    object-fit: cover;
  }

  .conversation-info {
    flex: 1;
  }

  .conversation-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 0.25rem;
  }

  .customer-name {
    font-weight: 500;
    color: #1a1a1a;
  }

  .conversation-time {
    font-size: 0.8rem;
    color: #666;
  }

  .conversation-preview {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
  }

  .last-message {
    color: #666;
    font-size: 0.9rem;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 200px;
  }

  .unread-badge {
    background: #4a90e2;
    color: white;
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
    border-radius: 1rem;
  }

  .status-badge {
    padding: 0.25rem 0.5rem;
    border-radius: 1rem;
    font-size: 0.75rem;
    font-weight: 500;
    text-transform: capitalize;
  }

  .status-badge.active {
    background: #dcfce7;
    color: #059669;
  }

  .status-badge.completed {
    background: #e0e7ff;
    color: #4f46e5;
  }

  .status-badge.pending {
    background: #fef3c7;
    color: #d97706;
  }

  .conversation-detail {
    display: flex;
    flex-direction: column;
    height: 100%;
  }

  .detail-header {
    padding: 1rem;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .customer-info {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  .customer-info h2 {
    margin: 0;
    font-size: 1.25rem;
  }

  .customer-email {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
  }

  .detail-actions {
    display: flex;
    gap: 0.5rem;
  }

  .action-btn {
    background: none;
    border: 1px solid #eee;
    padding: 0.5rem;
    border-radius: 0.5rem;
    color: #666;
    cursor: pointer;
    transition: all 0.2s;
  }

  .action-btn:hover {
    background: #f5f7fa;
  }

  .messages-container {
    flex: 1;
    padding: 1rem;
    overflow-y: auto;
  }

  .message-placeholder {
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #666;
  }

  .message-input {
    padding: 1rem;
    border-top: 1px solid #eee;
    display: flex;
    gap: 1rem;
  }

  .message-input input {
    flex: 1;
    padding: 0.75rem 1rem;
    border: 1px solid #eee;
    border-radius: 0.5rem;
    font-size: 0.9rem;
  }

  .send-btn {
    background: #4a90e2;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .send-btn:hover {
    background: #357abd;
  }

  .send-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .no-conversation {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .placeholder-content {
    text-align: center;
    color: #666;
  }

  .placeholder-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
    display: block;
  }

  .placeholder-content h2 {
    margin: 0 0 0.5rem;
    color: #1a1a1a;
  }

  .placeholder-content p {
    margin: 0;
  }

  @media (max-width: 1024px) {
    .conversations-container {
      grid-template-columns: 1fr;
    }

    .conversation-detail {
      display: none;
    }

    .conversations-list {
      border-right: none;
    }
  }

  @media (max-width: 768px) {
    .conversations-page {
      padding: 1rem;
    }

    .header-content {
      flex-direction: column;
      align-items: flex-start;
      gap: 1rem;
    }

    .filters {
      flex-direction: column;
      align-items: stretch;
    }

    .search-box {
      max-width: none;
    }
  }
</style>
