defmodule ContactingAIWeb.Router do
  use ContactingAIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ContactingAIWeb do
    pipe_through :api

    # Interaction routes
    post "/interaction", InteractionController, :create
    get "/interactions", InteractionController, :index
    get "/interaction/:id", InteractionController, :show

    # Analytics routes
    get "/analytics", AnalyticsController, :index
    get "/analytics/interactions", AnalyticsController, :interaction_stats
    get "/analytics/contacts", AnalyticsController, :contact_stats

    # Contact routes
    resources "/contacts", ContactController, except: [:new, :edit]
  end
end
