defmodule Tldb.AlbumTest do
  use Tldb.ModelCase

  alias Tldb.Album

  @valid_attrs %{artist: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Album.changeset(%Album{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Album.changeset(%Album{}, @invalid_attrs)
    refute changeset.valid?
  end
end
