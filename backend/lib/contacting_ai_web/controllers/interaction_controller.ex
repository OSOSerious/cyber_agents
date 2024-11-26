defmodule ContactingAIWeb.InteractionController do
  use ContactingAIWeb, :controller

  alias ContactingAI.Interactions
  alias ContactingAI.Interactions.Interaction

  def index(conn, params) do
    page = params["page"] || 1
    per_page = params["per_page"] || 20
    interactions = Interactions.list_interactions(page, per_page)
    render(conn, "index.json", interactions: interactions)
  end

  def show(conn, %{"id" => id}) do
    interaction = Interactions.get_interaction!(id)
    render(conn, "show.json", interaction: interaction)
  end

  def create(conn, params) do
    channel = params["channel"]
    interaction_data = process_interaction(channel, params)

    case Interactions.create_interaction(interaction_data) do
      {:ok, interaction} ->
        send_notification(interaction)
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.interaction_path(conn, :show, interaction))
        |> render("show.json", interaction: interaction)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ContactingAIWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp process_interaction(channel, params) do
    base_data = %{
      channel: channel,
      name: params["name"],
      sentiment: params["sentiment"]
    }

    channel_specific_data = case channel do
      "social" ->
        %{
          handle: params["handle"],
          platform: params["platform"],
          message: params["message"]
        }
      "email" ->
        %{
          email: params["email"],
          subject: params["subject"],
          message: params["message"]
        }
      "website" ->
        %{
          website: params["website"],
          page_visited: params["pageVisited"],
          feedback: params["feedback"],
          geolocation: params["geolocation"]
        }
      "phone" ->
        %{
          phone: params["phone"],
          call_purpose: params["callPurpose"],
          notes: params["notes"]
        }
    end

    Map.merge(base_data, channel_specific_data)
  end

  defp send_notification(interaction) do
    # Implement the logic to send notifications (e.g., email, Slack message)
    # This is a placeholder and should be replaced with actual notification logic
    IO.puts("New interaction received: #{inspect(interaction)}")
  end
end