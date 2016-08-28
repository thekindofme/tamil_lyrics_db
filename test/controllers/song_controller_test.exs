defmodule Tldb.SongControllerTest do
  use Tldb.ConnCase

  alias Tldb.Song
  alias Tldb.Album

  defp valid_attrs do
    %{
      native_lyrics: "some content", phonetic_script: "some content", title: "Best Song DDFAAW!", translated_to_en_lyrics: "some content", 
      album_id: Tldb.Repo.get_by(Album, title: "test").id
    }
  end

  @invalid_attrs %{}

  setup do
    Album.changeset(%Album{}, %{title: "test", artist: "test"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, song_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing songs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, song_path(conn, :new)
    assert html_response(conn, 200) =~ "New song"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, song_path(conn, :create), song: valid_attrs
    assert redirected_to(conn) == song_path(conn, :index)
    assert Repo.get_by(Song, valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, song_path(conn, :create), song: @invalid_attrs
    assert html_response(conn, 200) =~ "New song"
  end

  test "shows chosen resource", %{conn: conn} do
    song = Repo.insert! Song.changeset(%Song{}, valid_attrs)
    conn = get conn, song_path(conn, :show, song)
    assert html_response(conn, 200) =~ "Best Song DDFAAW!"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, song_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    song = Repo.insert! %Song{}
    conn = get conn, song_path(conn, :edit, song)
    assert html_response(conn, 200) =~ "Edit song"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    song = Repo.insert! %Song{}
    conn = put conn, song_path(conn, :update, song), song: valid_attrs
    assert redirected_to(conn) == song_path(conn, :show, song)
    assert Repo.get_by(Song, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    song = Repo.insert! %Song{}
    conn = put conn, song_path(conn, :update, song), song: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit song"
  end

  test "deletes chosen resource", %{conn: conn} do
    song = Repo.insert! %Song{}
    conn = delete conn, song_path(conn, :delete, song)
    assert redirected_to(conn) == song_path(conn, :index)
    refute Repo.get(Song, song.id)
  end
end
