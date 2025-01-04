defmodule ContactingAIWeb.ReviewController do
  use ContactingAIWeb, :controller

  alias ContactingAI.Reviews
  alias ContactingAI.Reviews.Review

  action_fallback ContactingAIWeb.FallbackController

  def index(conn, %{"agent_id" => agent_id}) do
    reviews = Reviews.list_agent_reviews(agent_id)
    stats = Reviews.get_agent_review_stats(agent_id)
    render(conn, :index, reviews: reviews, stats: stats)
  end

  def create(conn, %{"review" => review_params}) do
    with {:ok, %Review{} = review} <- Reviews.create_review(review_params) do
      review = Repo.preload(review, :user)

      conn
      |> put_status(:created)
      |> render(:show, review: review)
    end
  end

  def mark_helpful(conn, %{"id" => id}) do
    with {:ok, review} <- Reviews.mark_review_helpful(id) do
      render(conn, :show, review: review)
    end
  end

  def user_reviews(conn, %{"user_id" => user_id}) do
    reviews = Reviews.get_user_reviews(user_id)
    render(conn, :index, reviews: reviews)
  end
end
