defmodule Tldb.Repo.Migrations.AddAlbumIdToSongs do
  use Ecto.Migration

  def change do
    alter table(:songs) do
      add :album_id, references(:albums)
    end

    create index(:songs, [:album_id])
  end
end
