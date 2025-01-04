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
    profilePicture: 'https://example.com/profile.jpg',
    language: 'English',
    skills: [
      { name: 'Digital Marketing', level: 90 },
      { name: 'Content Strategy', level: 85 },
      { name: 'Social Media', level: 95 },
      { name: 'Analytics', level: 80 },
      { name: 'Project Management', level: 75 }
    ],
    experience: [
      {
        title: 'Marketing Director',
        company: 'TechCorp',
        period: '2020 - Present',
        description: 'Leading digital marketing initiatives and team management.'
      },
      {
        title: 'Senior Marketing Manager',
        company: 'InnovateCo',
        period: '2017 - 2020',
        description: 'Developed and executed marketing strategies for B2B products.'
      }
    ],
    agentInteractions: [
      {
        agentId: 'techinsightai',
        agentName: 'Tech Insight AI',
        lastInteraction: '2023-12-01',
        totalInteractions: 15,
        rating: 4.5
      },
      {
        agentId: 'strategymind',
        agentName: 'Strategy Mind',
        lastInteraction: '2023-11-28',
        totalInteractions: 8,
        rating: 5
      }
    ]
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
        <label for="language">Language</label>
        <select id="language" bind:value={user.language}>
          <option value="English">English</option>
          <option value="Spanish">Spanish</option>
          <option value="French">French</option>
          <option value="German">German</option>
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

  <!-- Skills Section -->
  <div class="skills-section mt-8">
    <h3 class="text-xl font-semibold mb-4">Skills & Expertise</h3>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      {#each user.skills as skill}
        <div class="skill-item">
          <div class="flex justify-between mb-1">
            <span class="text-sm font-medium">{skill.name}</span>
            <span class="text-sm text-gray-500">{skill.level}%</span>
          </div>
          <div class="w-full bg-gray-200 rounded-full h-2">
            <div
              class="bg-blue-600 h-2 rounded-full"
              style="width: {skill.level}%"
            ></div>
          </div>
        </div>
      {/each}
    </div>
  </div>

  <!-- Experience Section -->
  <div class="experience-section mt-8">
    <h3 class="text-xl font-semibold mb-4">Professional Experience</h3>
    <div class="space-y-6">
      {#each user.experience as exp}
        <div class="experience-item border-l-2 border-blue-500 pl-4">
          <h4 class="text-lg font-medium">{exp.title}</h4>
          <p class="text-gray-600">{exp.company} • {exp.period}</p>
          <p class="text-gray-700 mt-2">{exp.description}</p>
        </div>
      {/each}
    </div>
  </div>

  <!-- Agent Interactions History -->
  <div class="interactions-section mt-8">
    <h3 class="text-xl font-semibold mb-4">Agent Interactions</h3>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      {#each user.agentInteractions as interaction}
        <div class="interaction-card bg-white p-4 rounded-lg shadow">
          <h4 class="font-medium text-lg">{interaction.agentName}</h4>
          <div class="mt-2 space-y-1">
            <p class="text-sm text-gray-600">Last Interaction: {interaction.lastInteraction}</p>
            <p class="text-sm text-gray-600">Total Interactions: {interaction.totalInteractions}</p>
            <div class="flex items-center mt-2">
              <span class="text-sm text-gray-600 mr-2">Rating:</span>
              <div class="flex">
                {#each Array(5) as _, i}
                  <svg
                    class={`w-4 h-4 ${i < Math.floor(interaction.rating) ? 'text-yellow-400' : 'text-gray-300'}`}
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                {/each}
              </div>
            </div>
          </div>
        </div>
      {/each}
    </div>
  </div>

  <h3 class="mt-8">Change Password</h3>
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
