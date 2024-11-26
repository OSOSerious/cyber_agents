<script>
  import { theme } from '../stores/theme.js';

  let settings = {
    emailNotifications: true,
    darkMode: $theme === 'dark',
    language: 'English',
    timezone: 'UTC'
  };

  function toggleDarkMode() {
    settings.darkMode = !settings.darkMode;
    theme.set(settings.darkMode ? 'dark' : 'light');
  }

  function saveChanges() {
    // Here you would typically send the updated settings to your backend
    alert('Settings saved!');
  }
</script>

<div class="settings" class:dark={$theme === 'dark'}>
  <h2>Settings</h2>
  <div class="settings-form">
    <div class="form-group">
      <label>
        <input type="checkbox" bind:checked={settings.emailNotifications}>
        Email Notifications
      </label>
    </div>
    <div class="form-group">
      <label>
        <input type="checkbox" bind:checked={settings.darkMode} on:change={toggleDarkMode}>
        Dark Mode
      </label>
    </div>
    <div class="form-group">
      <label for="language">Language</label>
      <select id="language" bind:value={settings.language}>
        <option value="English">English</option>
        <option value="Spanish">Spanish</option>
        <option value="French">French</option>
        <option value="German">German</option>
      </select>
    </div>
    <div class="form-group">
      <label for="timezone">Timezone</label>
      <select id="timezone" bind:value={settings.timezone}>
        <option value="UTC">UTC</option>
        <option value="EST">EST</option>
        <option value="CST">CST</option>
        <option value="PST">PST</option>
      </select>
    </div>
    <button on:click={saveChanges}>Save Changes</button>
  </div>
</div>

<style>
  .settings {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
  }

  .settings-form {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .form-group {
    margin-bottom: 15px;
  }

  label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
  }

  input[type="checkbox"] {
    margin-right: 10px;
  }

  select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color: #2980b9;
  }

  .dark .settings-form {
    background-color: #2c3e50;
    color: #ecf0f1;
  }

  .dark select {
    background-color: #34495e;
    color: #ecf0f1;
    border-color: #2c3e50;
  }

  .dark button {
    background-color: #2980b9;
  }

  .dark button:hover {
    background-color: #3498db;
  }
</style>