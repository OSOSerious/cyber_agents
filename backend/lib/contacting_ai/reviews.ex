defmodule ContactingAI.Reviews do
  import Ecto.Query
  alias ContactingAI.Repo
  alias ContactingAI.Reviews.Review

  def list_agent_reviews(agent_id) do
    Review
    |> where([r], r.agent_id == ^agent_id)
    |> preload(:user)
    |> Repo.all()
  end

  def get_agent_review_stats(agent_id) do
    query = from r in Review,
      where: r.agent_id == ^agent_id,
      select: %{
        average_rating: avg(r.rating),
        total_reviews: count(r.id),
        rating_distribution: fragment(
          """
          json_build_object(
            '1', COUNT(*) FILTER (WHERE rating = 1),
            '2', COUNT(*) FILTER (WHERE rating = 2),
            '3', COUNT(*) FILTER (WHERE rating = 3),
            '4', COUNT(*) FILTER (WHERE rating = 4),
            '5', COUNT(*) FILTER (WHERE rating = 5)
          )
          """
        )
      }

    Repo.one(query) || %{
      average_rating: 0,
      total_reviews: 0,
      rating_distribution: %{"1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0}
    }
  end

  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  def mark_review_helpful(review_id) do
    {count, [review]} =
      from(r in Review, where: r.id == ^review_id)
      |> select([r], r)
      |> Repo.update_all(
        [inc: [helpful_count: 1]],
        returning: true
      )

    if count > 0, do: {:ok, review}, else: {:error, :not_found}
  end

  def get_user_reviews(user_id) do
    Review
    |> where([r], r.user_id == ^user_id)
    |> preload(:agent)
    |> Repo.all()
  end

  def get_review!(id), do: Repo.get!(Review, id)

  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end
end
