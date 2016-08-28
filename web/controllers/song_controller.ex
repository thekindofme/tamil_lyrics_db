defmodule Tldb.SongController do
  use Tldb.Web, :controller

  alias Tldb.Song
  alias Tldb.Album

  plug :load_albums when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    songs = Repo.all(Song)
    render(conn, "index.html", songs: songs)
  end

  def new(conn, _params) do
    changeset = Song.changeset(%Song{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"song" => song_params}) do
    changeset = Song.changeset(%Song{}, song_params)

    case Repo.insert(changeset) do
      {:ok, _song} ->
        conn
        |> put_flash(:info, "Song created successfully.")
        |> redirect(to: song_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    song = Repo.get!(Song, id)
    render(conn, "show.html", song: song)
  end

  def edit(conn, %{"id" => id}) do
    song = Repo.get!(Song, id)
    changeset = Song.changeset(song)
    render(conn, "edit.html", song: song, changeset: changeset)
  end

  def update(conn, %{"id" => id, "song" => song_params}) do
    song = Repo.get!(Song, id)
    changeset = Song.changeset(song, song_params)

    case Repo.update(changeset) do
      {:ok, song} ->
        conn
        |> put_flash(:info, "Song updated successfully.")
        |> redirect(to: song_path(conn, :show, song))
      {:error, changeset} ->
        render(conn, "edit.html", song: song, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    song = Repo.get!(Song, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(song)

    conn
    |> put_flash(:info, "Song deleted successfully.")
    |> redirect(to: song_path(conn, :index))
  end

  defp load_albums(conn, _) do
    query =
      Album
      |> Album.alphabetical
      |> Album.titles_and_ids
    albums = Repo.all(query)  
    assign(conn, :albums, albums)
  end
end
