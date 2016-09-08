defmodule PhoenixLobsters.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
     create table(:tags) do
      add :title, :string
      add :description, :string

      timestamps
    end
    create unique_index(:tags, [:title])

    create table(:story_tags) do
      add :story_id, references(:stories)
      add :tag_id, references(:tags)

      timestamps
    end
    
  end
end
