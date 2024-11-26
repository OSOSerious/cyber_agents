<script>
  import { Link } from 'svelte-routing';
</script>

<main>
  <h1>Welcome to ContactingAI</h1>

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
    <h2>Pipeline</h2>
    <p>Manage your sales pipeline and track deals.</p>
    <Link to="/pipeline">View Pipeline</Link>
  </section>

  <section>
    <h2>Calendar</h2>
    <p>Stay on top of your customer interactions.</p>
    <Link to="/calendar">View Calendar</Link>
  </section>

  <section>
    <h2>Websites</h2>
    <p>Create and manage your AI-powered websites.</p>
    <Link to="/websites">Manage Websites</Link>
  </section>
</main>

<style>
  main {
    padding: 20px;
  }

  section {
    margin-bottom: 40px;
  }
</style>
