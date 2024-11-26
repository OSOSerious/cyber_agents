<script>
  import { theme } from '../stores/theme.js';

  let websites = [
    { name: 'example.com', submissions: 5 },
    { name: 'contacting.ai', submissions: 8 },
    { name: 'clientsite.com', submissions: 3 }
  ];

  function viewDetails(website) {
    alert(`Viewing details for ${website.name}`);
    // In a real application, this would navigate to a detailed view of the website
  }
</script>

<div class="websites" class:dark={$theme === 'dark'}>
  <h2>Websites</h2>
  <div class="website-list">
    {#each websites as website}
      <div class="website-card">
        <h3>{website.name}</h3>
        <p>Recent form submissions: {website.submissions}</p>
        <button on:click={() => viewDetails(website)}>View Details</button>
      </div>
    {/each}
  </div>
</div>

<style>
  .websites {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
  }

  .website-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
  }

  .website-card {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
    transition: transform 0.2s;
  }

  .website-card:hover {
    transform: translateY(-5px);
  }

  h3 {
    margin-top: 0;
  }

  button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
  }

  button:hover {
    background-color: #2980b9;
  }

  .dark .website-card {
    background-color: #2c3e50;
    color: #ecf0f1;
  }

  .dark button {
    background-color: #2980b9;
  }

  .dark button:hover {
    background-color: #3498db;
  }
</style>