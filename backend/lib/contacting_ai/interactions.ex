defmodule ContactingAI.Interactions do
  @moduledoc """
  The Interactions context.
  """

  import Ecto.Query, warn: false
  alias ContactingAI.Repo

  alias ContactingAI.Interactions.Interaction

  @doc """
  Returns the list of interactions.

  ## Examples

      iex> list_interactions()
      [%Interaction{}, ...]

  """
  def list_interactions do
    Repo.all(Interaction)
  end

  @doc """
  Gets a single interaction.

  Raises `Ecto.NoResultsError` if the Interaction does not exist.

  ## Examples

      iex> get_interaction!(123)
      %Interaction{}

      iex> get_interaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_interaction!(id), do: Repo.get!(Interaction, id)

  @doc """
  Creates a interaction.

  ## Examples

      iex> create_interaction(%{field: value})
      {:ok, %Interaction{}}

      iex> create_interaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_interaction(attrs \\ %{}) do
    %Interaction{}
    |> Interaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a interaction.

  ## Examples

      iex> update_interaction(interaction, %{field: new_value})
      {:ok, %Interaction{}}

      iex> update_interaction(interaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_interaction(%Interaction{} = interaction, attrs) do
    interaction
    |> Interaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a interaction.

  ## Examples

      iex> delete_interaction(interaction)
      {:ok, %Interaction{}}

      iex> delete_interaction(interaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_interaction(%Interaction{} = interaction) do
    Repo.delete(interaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking interaction changes.

  ## Examples

      iex> change_interaction(interaction)
      %Ecto.Changeset{data: %Interaction{}}

  """
  def change_interaction(%Interaction{} = interaction, attrs \\ %{}) do
    Interaction.changeset(interaction, attrs)
  end

  @doc """
  Returns a list of interactions with pagination.

  ## Examples

      iex> list_interactions(1, 20)
      [%Interaction{}, ...]

  """
  def list_interactions(page, per_page) do
    Interaction
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(page: page, page_size: per_page)
  end

  @doc """
  Returns a list of interactions for a specific contact.

  ## Examples

      iex> list_interactions_by_contact(contact_id)
      [%Interaction{}, ...]

  """
  def list_interactions_by_contact(contact_id) do
    Interaction
    |> where(contact_id: ^contact_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end
end