defmodule PhoenixLobsters.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :slug, :string
      add :compiled_html, :string
      add :uncompiled_markdown, :string
      add :user_id, references(:users)
      add :story_id, references(:stories)
      add :comment_id, references(:comments)
      add :status, :string, default: "active"

      timestamps
    end
  end
end
