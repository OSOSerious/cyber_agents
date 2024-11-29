<script>
  export let videos = [
    { id: 1, title: 'Introduction to ContactingAI', url: 'https://www.example.com/video1' },
    { id: 2, title: 'Setting Up Your Profile', url: 'https://www.example.com/video2' },
    { id: 3, title: 'Connecting Communication Channels', url: 'https://www.example.com/video3' },
    { id: 4, title: 'Creating Your First Campaign', url: 'https://www.example.com/video4' },
    { id: 5, title: 'Exploring the Analytics Dashboard', url: 'https://www.example.com/video5' }
  ];
</script>

<div class="video-tutorials">
  <h2>Video Tutorials</h2>
  <ul>
    {#each videos as video}
      <li>
        <a href={video.url} target="_blank" rel="noopener noreferrer">{video.title}</a>
      </li>
    {/each}
  </ul>
</div>

<style>
  .video-tutorials {
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
    margin-bottom: 0.75rem;
  }

  a {
    color: #4a90e2;
    text-decoration: none;
    transition: color 0.2s;
  }

  a:hover {
    color: #357abd;
  }
</style>
