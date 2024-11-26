defmodule ContactingAIWeb.AnalyticsController do
  use ContactingAIWeb, :controller

  alias ContactingAI.Analytics

  def index(conn, _params) do
    analytics_data = %{
      total_contacts: Analytics.get_total_contacts(),
      total_interactions: Analytics.get_total_interactions(),
      conversion_rate: Analytics.get_conversion_rate(),
      recent_activity: Analytics.get_recent_activity(),
      interaction_breakdown: Analytics.get_interaction_breakdown(),
      contact_growth: Analytics.get_contact_growth()
    }

    json(conn, analytics_data)
  end

  def interaction_stats(conn, params) do
    start_date = params["start_date"]
    end_date = params["end_date"]

    stats = %{
      total_interactions: Analytics.get_total_interactions(start_date, end_date),
      interactions_by_channel: Analytics.get_interactions_by_channel(start_date, end_date),
      average_sentiment: Analytics.get_average_sentiment(start_date, end_date),
      peak_interaction_times: Analytics.get_peak_interaction_times(start_date, end_date)
    }

    json(conn, stats)
  end

  def contact_stats(conn, params) do
    start_date = params["start_date"]
    end_date = params["end_date"]

    stats = %{
      total_contacts: Analytics.get_total_contacts(start_date, end_date),
      new_contacts: Analytics.get_new_contacts(start_date, end_date),
      contact_growth_rate: Analytics.get_contact_growth_rate(start_date, end_date),
      most_active_contacts: Analytics.get_most_active_contacts(start_date, end_date)
    }

    json(conn, stats)
  end
end