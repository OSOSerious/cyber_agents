defmodule ContactingAI.Analytics do
  import Ecto.Query
  alias ContactingAI.Repo
  alias ContactingAI.Contacts.Contact
  alias ContactingAI.Interactions.Interaction

  def get_total_contacts(start_date \\ nil, end_date \\ nil) do
    Contact
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> Repo.aggregate(:count, :id)
  end

  def get_total_interactions(start_date \\ nil, end_date \\ nil) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> Repo.aggregate(:count, :id)
  end

  def get_conversion_rate do
    # Implement conversion rate calculation logic
    # This is a placeholder
    2.5
  end

  def get_recent_activity(limit \\ 10) do
    Interaction
    |> order_by(desc: :inserted_at)
    |> limit(^limit)
    |> Repo.all()
    |> Enum.map(&format_activity/1)
  end

  def get_interaction_breakdown(start_date \\ nil, end_date \\ nil) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> group_by(:channel)
    |> select([i], {i.channel, count(i.id)})
    |> Repo.all()
    |> Enum.into(%{})
  end

  def get_contact_growth(interval \\ "month", last_n \\ 6) do
    end_date = Date.utc_today()
    start_date = Date.add(end_date, -last_n * get_interval_days(interval))

    Contact
    |> where([c], c.inserted_at >= ^start_date and c.inserted_at <= ^end_date)
    |> group_by([c], fragment("date_trunc(?, ?)", ^interval, c.inserted_at))
    |> select([c], {fragment("date_trunc(?, ?)", ^interval, c.inserted_at), count(c.id)})
    |> order_by([c], asc: fragment("date_trunc(?, ?)", ^interval, c.inserted_at))
    |> Repo.all()
  end

  def get_interactions_by_channel(start_date \\ nil, end_date \\ nil) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> group_by(:channel)
    |> select([i], {i.channel, count(i.id)})
    |> Repo.all()
    |> Enum.into(%{})
  end

  def get_average_sentiment(start_date \\ nil, end_date \\ nil) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> select([i], avg(i.sentiment))
    |> Repo.one()
  end

  def get_peak_interaction_times(start_date \\ nil, end_date \\ nil) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> group_by([i], fragment("date_part('hour', ?)", i.inserted_at))
    |> select([i], {fragment("date_part('hour', ?)", i.inserted_at), count(i.id)})
    |> order_by([i], desc: count(i.id))
    |> limit(5)
    |> Repo.all()
  end

  def get_new_contacts(start_date \\ nil, end_date \\ nil) do
    Contact
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> Repo.aggregate(:count, :id)
  end

  def get_contact_growth_rate(start_date \\ nil, end_date \\ nil) do
    new_contacts = get_new_contacts(start_date, end_date)
    total_contacts = get_total_contacts()
    
    if total_contacts > 0 do
      (new_contacts / total_contacts) * 100
    else
      0
    end
  end

  def get_most_active_contacts(start_date \\ nil, end_date \\ nil, limit \\ 10) do
    Interaction
    |> date_range_filter(:inserted_at, start_date, end_date)
    |> group_by([i], i.contact_id)
    |> select([i], {i.contact_id, count(i.id)})
    |> order_by([i], desc: count(i.id))
    |> limit(^limit)
    |> Repo.all()
    |> Enum.map(fn {contact_id, interaction_count} ->
      contact = Repo.get(Contact, contact_id)
      %{
        id: contact.id,
        name: contact.name,
        email: contact.email,
        interaction_count: interaction_count
      }
    end)
  end

  defp date_range_filter(query, field, nil, nil), do: query
  defp date_range_filter(query, field, start_date, nil) do
    from q in query, where: field(q, ^field) >= ^start_date
  end
  defp date_range_filter(query, field, nil, end_date) do
    from q in query, where: field(q, ^field) <= ^end_date
  end
  defp date_range_filter(query, field, start_date, end_date) do
    from q in query, where: field(q, ^field) >= ^start_date and field(q, ^field) <= ^end_date
  end

  defp get_interval_days("day"), do: 1
  defp get_interval_days("week"), do: 7
  defp get_interval_days("month"), do: 30
  defp get_interval_days("year"), do: 365

  defp format_activity(interaction) do
    "#{interaction.channel} interaction: #{interaction.name} - #{interaction.inserted_at}"
  end
end