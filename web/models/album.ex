defmodule Tldb.Album do
  use Tldb.Web, :model

  schema "albums" do
    field :title, :string
    field :artist, :string
    has_many :songs, Tldb.Song

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :artist])
    |> validate_required([:title, :artist])
  end

  def alphabetical(query) do
    from c in query, order_by: c.title
  end

  def titles_and_ids(query) do
    from c in query, select: {c.title, c.id}
  end
end
