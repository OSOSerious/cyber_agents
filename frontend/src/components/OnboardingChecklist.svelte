<script>
  export let tasks = [
    { id: 1, title: 'Set up a profile', completed: false },
    { id: 2, title: 'Connect communication channels', completed: false },
    { id: 3, title: 'Create the first campaign', completed: false },
    { id: 4, title: 'Explore the analytics dashboard', completed: false },
    { id: 5, title: 'Review recent activity', completed: false },
    { id: 6, title: 'Customize notification settings', completed: false },
    { id: 7, title: 'Learn about AI-powered responses', completed: false },
    { id: 8, title: 'Understand human handoff process', completed: false },
    { id: 9, title: 'Watch video tutorials', completed: false },
    { id: 10, title: 'Read the user manual', completed: false }
  ];

  function toggleTaskCompletion(taskId) {
    const task = tasks.find(t => t.id === taskId);
    if (task) {
      task.completed = !task.completed;
    }
  }
</script>

<div class="onboarding-checklist">
  <h2>Onboarding Checklist</h2>
  <ul>
    {#each tasks as task}
      <li class:completed={task.completed}>
        <label>
          <input type="checkbox" checked={task.completed} on:change={() => toggleTaskCompletion(task.id)} />
          {task.title}
        </label>
      </li>
    {/each}
  </ul>
</div>

<style>
  .onboarding-checklist {
    background: white;
    padding: 1.5rem;
    border-radius: 0.75rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  h2 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
  }

  ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  li {
    display: flex;
    align-items: center;
    margin-bottom: 0.75rem;
  }

  li.completed label {
    text-decoration: line-through;
    color: #999;
  }

  input[type="checkbox"] {
    margin-right: 0.75rem;
  }
</style>
