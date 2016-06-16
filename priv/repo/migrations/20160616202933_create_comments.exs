defmodule PhoenixLobsters.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :slug, :string
      add :compiled_html, :string
      add :uncompiled_markdown, :string
      add :author, references(:users)
      add :story, references(:stories)
      add :comment, references(:comments)
      add :status, :string, default: "active"

      timestamps
    end
  end
end
