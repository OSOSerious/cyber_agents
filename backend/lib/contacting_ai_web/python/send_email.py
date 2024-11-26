import sys
import smtplib
from email.mime.text import MIMEText
import os

def send_email(subject, email, message):
    # Set your email server configuration
    smtp_server = "smtp.gmail.com"
    port = 587
    sender_email = os.environ.get("SENDER_EMAIL")
    password = os.environ.get("EMAIL_PASSWORD")

    if not sender_email or not password:
        print("Error: Email credentials not set in environment variables.")
        sys.exit(1)

    # Create the email content
    msg = MIMEText(f"From: {email}\n\n{message}")
    msg['Subject'] = subject
    msg['From'] = sender_email
    msg['To'] = sender_email  # Send to yourself or a designated email

    try:
        # Connect to the server and send the email
        server = smtplib.SMTP(smtp_server, port)
        server.starttls()  # Secure the connection
        server.login(sender_email, password)
        server.sendmail(sender_email, sender_email, msg.as_string())
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        print(f"Error sending email: {e}")
        sys.exit(1)

if __name__ == "__main__":
    # Receive arguments from the Elixir backend
    if len(sys.argv) != 4:
        print("Error: Incorrect number of arguments")
        sys.exit(1)
    
    subject = sys.argv[1]
    email = sys.argv[2]
    message = sys.argv[3]
    send_email(subject, email, message)