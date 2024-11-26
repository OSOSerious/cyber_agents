<script>
  export let title = "Transformative Platform Features";
  export let features = [
    "Instant POC (Point of Contact): AI or human agents connect with customers in real time, responding to interest and intent immediately.",
    "Omni-Channel Strategy: Customers are engaged through voice, chat, and SMS — no emails.",
    "Automated Follow-Ups with Real-Time Agents: AI or human agents follow up instantly, increasing conversion rates.",
    "Personalized Interactions: Every contact is tailored based on customer behavior and preferences."
  ];
</script>

<div class="key-platform-features">
  <h1>{title}</h1>
  <ul>
    {#each features as feature}
      <li>{feature}</li>
    {/each}
  </ul>
</div>

<style>
  .key-platform-features {
    padding: 2rem;
  }

  h1 {
    font-size: 2.5rem;
    margin-bottom: 1rem;
  }

  ul {
    list-style-type: disc;
    padding-left: 2rem;
  }

  li {
    font-size: 1.25rem;
    margin-bottom: 0.5rem;
  }
</style>
