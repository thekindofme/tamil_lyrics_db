defmodule Tldb.Song do
  use Tldb.Web, :model

  schema "songs" do
    field :title, :string
    field :native_lyrics, :string
    field :translated_to_en_lyrics, :string
    field :phonetic_script, :string
    belongs_to :album, Tldb.Album

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :native_lyrics, :translated_to_en_lyrics, :phonetic_script, :album_id])
    |> validate_required([:title, :native_lyrics, :translated_to_en_lyrics, :phonetic_script, :album_id])
  end
end
