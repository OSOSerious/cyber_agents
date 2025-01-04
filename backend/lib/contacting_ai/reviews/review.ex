defmodule ContactingAI.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :rating, :integer
    field :review_text, :string
    field :helpful_count, :integer, default: 0
    belongs_to :user, ContactingAI.Accounts.User
    belongs_to :agent, ContactingAI.Agents.Agent

    timestamps()
  end

  def changeset(review, attrs) do
    review
    |> cast(attrs, [:rating, :review_text, :helpful_count, :user_id, :agent_id])
    |> validate_required([:rating, :user_id, :agent_id])
    |> validate_inclusion(:rating, 1..5)
  end
end
