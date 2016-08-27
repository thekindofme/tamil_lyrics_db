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
    |> cast(params, [:title, :artist, :song])
    |> validate_required([:title, :artist, :song])
  end
end
