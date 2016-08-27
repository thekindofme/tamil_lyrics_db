defmodule Tldb.SongTest do
  use Tldb.ModelCase

  alias Tldb.Song

  @valid_attrs %{native_lyrics: "some content", phonetic_script: "some content", title: "some content", translated_to_en_lyrics: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Song.changeset(%Song{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Song.changeset(%Song{}, @invalid_attrs)
    refute changeset.valid?
  end
end
