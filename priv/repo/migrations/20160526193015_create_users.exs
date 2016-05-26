defmodule PhoenixLobsters.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :display_name, :string
      add :hashed_password, :string
      add :description_markdown, :text
      add :description_html, :text

      timestamps
    end
  end
end
