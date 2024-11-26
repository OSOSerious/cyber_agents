defmodule ContactingAI.Interactions.Interaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interactions" do
    field :channel, :string
    field :sentiment, :float
    field :content, :string
    field :metadata, :map

    belongs_to :contact, ContactingAI.Contacts.Contact

    timestamps()
  end

  @doc false
  def changeset(interaction, attrs) do
    interaction
    |> cast(attrs, [:channel, :sentiment, :content, :metadata, :contact_id])
    |> validate_required([:channel, :content, :contact_id])
    |> validate_inclusion(:channel, ["email", "phone", "social", "website"])
    |> validate_number(:sentiment, greater_than_or_equal_to: -1, less_than_or_equal_to: 1)
    |> foreign_key_constraint(:contact_id)
  end
end