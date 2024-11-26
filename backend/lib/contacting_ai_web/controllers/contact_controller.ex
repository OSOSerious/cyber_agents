defmodule ContactingAIWeb.ContactController do
  use ContactingAIWeb, :controller

  alias ContactingAI.Contacts
  alias ContactingAI.Contacts.Contact

  action_fallback ContactingAIWeb.FallbackController

  def index(conn, _params) do
    contacts = Contacts.list_contacts()
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, %{"contact" => contact_params}) do
    with {:ok, %Contact{} = contact} <- Contacts.create_contact(contact_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.contact_path(conn, :show, contact))
      |> render("show.json", contact: contact)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)
    render(conn, "show.json", contact: contact)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Contacts.get_contact!(id)

    with {:ok, %Contact{} = contact} <- Contacts.update_contact(contact, contact_params) do
      render(conn, "show.json", contact: contact)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)

    with {:ok, %Contact{}} <- Contacts.delete_contact(contact) do
      send_resp(conn, :no_content, "")
    end
  end

  def send_email(conn, %{"name" => name, "email" => email, "message" => message}) do
    case send_email_python(name, email, message) do
      :ok -> 
        conn
        |> put_status(:ok)
        |> json(%{message: "Email sent successfully"})
      _ -> 
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Error sending email"})
    end
  end

  defp send_email_python(name, email, message) do
    # Call Python script to send email
    case System.cmd("python3", ["#{File.cwd!()}/lib/contacting_ai_web/python/send_email.py", name, email, message]) do
      {_, 0} -> :ok
      _ -> :error
    end
  end
end