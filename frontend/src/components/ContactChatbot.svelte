<script>
  export let contact;
  
  let messages = [];
  let inputText = '';

  function sendMessage() {
    if (inputText.trim() !== '') {
      messages = [...messages, { text: inputText, sender: 'user' }];
      inputText = '';
      getChatbotResponse();
    }
  }

  async function getChatbotResponse() {
    try {
      const response = await fetch('/api/chatbot', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 
          contactId: contact.id,
          message: messages[messages.length - 1].text
        })
      });

      if (!response.ok) {
        throw new Error('Failed to get chatbot response');
      }

      const data = await response.json();
      messages = [...messages, { text: data.response, sender: 'bot' }];
    } catch (error) {
      console.error('Error:', error);
      messages = [...messages, { text: 'Oops, something went wrong!', sender: 'bot' }];
    }
  }
</script>

<div class="chatbot">
  <h3>Contact Chatbot</h3>
  <div class="messages">
    {#each messages as message}
      <div class="message" class:user={message.sender === 'user'} class:bot={message.sender === 'bot'}>
        {message.text}
      </div>
    {/each}
  </div>
  <div class="input-area">
    <input type="text" bind:value={inputText} placeholder="Type your message..." on:keydown={(e) => e.key === 'Enter' && sendMessage()}>
    <button on:click={sendMessage}>Send</button>
  </div>
</div>

<style>
  .chatbot {
    background-color: white;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 10px;
    max-width: 400px;
    margin: 20px auto;
  }

  .messages {
    max-height: 300px;
    overflow-y: auto;
    margin-bottom: 10px;
  }

  .message {
    padding: 5px 10px;
    margin-bottom: 5px;
    border-radius: 5px;
  }

  .user {
    background-color: #2980b9;
    color: white;
    align-self: flex-end;
  }

  .bot {
    background-color: #f0f0f0;
  }

  .input-area {
    display: flex;
  }

  input {
    flex-grow: 1;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 3px;
    margin-right: 5px;
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
    cursor: pointer;
    border-radius: 3px;
  }
</style>