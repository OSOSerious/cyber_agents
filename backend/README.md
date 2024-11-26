# ContactingAI Backend

This is the backend for the ContactingAI project, built with Phoenix (Elixir) and integrated with a Python script for handling various types of interactions.

## Setup

1. Ensure you have Elixir and Phoenix installed on your system.
2. Install Python 3 if it's not already installed.
3. Navigate to the backend directory:
   ```
   cd backend
   ```
4. Install dependencies:
   ```
   mix deps.get
   ```
5. Set up the database:
   ```
   mix ecto.setup
   ```

## Environment Variables

Before running the application, you need to set up the following environment variables:

- `SENDER_EMAIL`: The email address from which emails will be sent.
- `EMAIL_PASSWORD`: The password for the sender email account.

You can set these variables in your shell or create a `.env` file in the root of the backend directory:

```
export SENDER_EMAIL=your_email@example.com
export EMAIL_PASSWORD=your_email_password
```

**Note**: If you're using Gmail, you might need to use an "App Password" instead of your regular password. You can set this up in your Google Account settings.

## Running the Application

1. Start the Phoenix server:
   ```
   mix phx.server
   ```

The server will start on [`localhost:4000`](http://localhost:4000) by default.

## API Endpoints

- `POST /api/interaction`: Submit an interaction
  - Body: `{ "type": "contact", "name": "John Doe", "email": "john@example.com", "message": "Hello, world!" }`

  Supported interaction types:
  - "contact": General contact form
  - "feedback": User feedback
  - "support": Support request

## Using the InteractionPoint Component

In your Svelte frontend, you can use the InteractionPoint component to create customizable interaction points. Here's an example of how to use it:

```svelte
<script>
  import InteractionPoint from './components/InteractionPoint.svelte';

  const contactFields = [
    { name: 'name', label: 'Name', type: 'text', required: true },
    { name: 'email', label: 'Email', type: 'email', required: true },
    { name: 'message', label: 'Message', type: 'textarea', required: true }
  ];

  const feedbackFields = [
    { name: 'email', label: 'Email', type: 'email', required: true },
    { name: 'feedback', label: 'Feedback', type: 'textarea', required: true }
  ];

  function handleSuccess(event) {
    console.log(event.detail.message);
  }

  function handleError(event) {
    console.error(event.detail.message);
  }
</script>

<InteractionPoint
  type="contact"
  title="Contact Us"
  fields={contactFields}
  on:success={handleSuccess}
  on:error={handleError}
/>

<InteractionPoint
  type="feedback"
  title="Provide Feedback"
  fields={feedbackFields}
  submitButtonText="Send Feedback"
  on:success={handleSuccess}
  on:error={handleError}
/>
```

You can customize the `type`, `title`, `fields`, and `submitButtonText` props to create different types of interaction points throughout your application.

## Troubleshooting

- If you encounter issues with the Python script, ensure that Python 3 is installed and accessible from the command line.
- Make sure the environment variables are correctly set before starting the Phoenix server.
- Check the console output for any error messages related to email sending or Python script execution.

## Security Note

Remember to keep your email credentials secure and never commit them to version control. The `.env` file should be added to your `.gitignore` file.