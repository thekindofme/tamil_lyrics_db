defmodule Tldb.Repo.Migrations.CreateSong do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :title, :string
      add :native_lyrics, :text
      add :translated_to_en_lyrics, :text
      add :phonetic_script, :text

      timestamps()
    end

  end
end
