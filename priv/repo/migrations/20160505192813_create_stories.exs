defmodule PhoenixLobsters.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table( :stories ) do
      add :title, :string
      add :url, :string
      add :uncompiled_markdown, :text
      add :compiled_html, :text
      add :is_author, :boolean
      add :submission_date, :datetime
      add :slug, :string
      add :votes, :integer
      add :score, :float
      add :status, :string

      timestamps
    end
  end
end
