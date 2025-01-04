defmodule ContactingAIWeb.ReviewJSON do
  alias ContactingAI.Reviews.Review

  def index(%{reviews: reviews, stats: stats}) do
    %{
      data: for(review <- reviews, do: data(review)),
      stats: %{
        average_rating: stats.average_rating,
        total_reviews: stats.total_reviews,
        rating_distribution: stats.rating_distribution
      }
    }
  end

  def index(%{reviews: reviews}) do
    %{data: for(review <- reviews, do: data(review))}
  end

  def show(%{review: review}) do
    %{data: data(review)}
  end

  defp data(%Review{} = review) do
    %{
      id: review.id,
      rating: review.rating,
      review_text: review.review_text,
      helpful_count: review.helpful_count,
      inserted_at: review.inserted_at,
      user: if(Ecto.assoc_loaded?(review.user), do: %{
        id: review.user.id,
        name: review.user.name
      }),
      agent: if(Ecto.assoc_loaded?(review.agent), do: %{
        id: review.agent.id,
        name: review.agent.name
      })
    }
  end
end
