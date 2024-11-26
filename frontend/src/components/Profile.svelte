<script>
  import { theme } from '../stores/theme.js';

  let user = {
    name: 'John Doe',
    email: 'john@example.com',
    company: 'TechCorp',
    position: 'Marketing Manager',
    bio: "I'm a passionate marketer with 10 years of experience in digital advertising.",
    phone: '+1 (555) 123-4567',
    address: '123 Main St, Anytown, USA',
    timezone: 'UTC-5',
    linkedin: 'https://linkedin.com/in/johndoe',
    twitter: '@johndoe',
    profilePicture: 'https://example.com/profile.jpg'
  };

  let passwordChange = {
    currentPassword: '',
    newPassword: '',
    confirmPassword: ''
  };

  function saveChanges() {
    // Here you would typically send the updated user data to your backend
    alert('Profile changes saved!');
  }

  function changePassword() {
    if (passwordChange.newPassword !== passwordChange.confirmPassword) {
      alert('New passwords do not match!');
      return;
    }
    // Here you would typically send the password change request to your backend
    alert('Password changed successfully!');
    passwordChange = { currentPassword: '', newPassword: '', confirmPassword: '' };
  }

  function uploadProfilePicture() {
    // Here you would typically implement file upload functionality
    alert('Profile picture upload functionality would be implemented here.');
  }
</script>

<div class="profile" class:dark={$theme === 'dark'}>
  <h2>Profile</h2>
  <div class="profile-content">
    <div class="profile-picture">
      <img src={user.profilePicture} alt="Profile Picture" />
      <button on:click={uploadProfilePicture}>Change Picture</button>
    </div>
    <div class="profile-form">
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" id="name" bind:value={user.name}>
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" bind:value={user.email}>
      </div>
      <div class="form-group">
        <label for="phone">Phone</label>
        <input type="tel" id="phone" bind:value={user.phone}>
      </div>
      <div class="form-group">
        <label for="company">Company</label>
        <input type="text" id="company" bind:value={user.company}>
      </div>
      <div class="form-group">
        <label for="position">Position</label>
        <input type="text" id="position" bind:value={user.position}>
      </div>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" bind:value={user.address}>
      </div>
      <div class="form-group">
        <label for="timezone">Timezone</label>
        <select id="timezone" bind:value={user.timezone}>
          <option value="UTC-12">UTC-12</option>
          <option value="UTC-11">UTC-11</option>
          <!-- Add more timezone options -->
          <option value="UTC+12">UTC+12</option>
        </select>
      </div>
      <div class="form-group">
        <label for="linkedin">LinkedIn</label>
        <input type="url" id="linkedin" bind:value={user.linkedin}>
      </div>
      <div class="form-group">
        <label for="twitter">Twitter</label>
        <input type="text" id="twitter" bind:value={user.twitter}>
      </div>
      <div class="form-group">
        <label for="bio">Bio</label>
        <textarea id="bio" bind:value={user.bio}></textarea>
      </div>
      <button on:click={saveChanges}>Save Changes</button>
    </div>
  </div>

  <h3>Change Password</h3>
  <div class="password-change">
    <div class="form-group">
      <label for="currentPassword">Current Password</label>
      <input type="password" id="currentPassword" bind:value={passwordChange.currentPassword}>
    </div>
    <div class="form-group">
      <label for="newPassword">New Password</label>
      <input type="password" id="newPassword" bind:value={passwordChange.newPassword}>
    </div>
    <div class="form-group">
      <label for="confirmPassword">Confirm New Password</label>
      <input type="password" id="confirmPassword" bind:value={passwordChange.confirmPassword}>
    </div>
    <button on:click={changePassword}>Change Password</button>
  </div>
</div>

<style>
  .profile {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }

  .profile-content {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
  }

  .profile-picture {
    flex: 0 0 200px;
    text-align: center;
  }

  .profile-picture img {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 10px;
  }

  .profile-form {
    flex: 1;
  }

  .profile-form, .password-change {
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

  input, textarea, select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  textarea {
    height: 100px;
    resize: vertical;
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

  .dark .profile-form, .dark .password-change {
    background-color: #2c3e50;
    color: #ecf0f1;
  }

  .dark input, .dark textarea, .dark select {
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