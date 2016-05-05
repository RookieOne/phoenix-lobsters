defmodule PhoenixLobster.Story do
	use HelloPhoenix.Web, :model

    @moduledoc """
    The Story module is responsible for stories submitted to the Phoenix Lobster.
    """

    schema "stories" do

      field :title, :string
      field :url, :string
      field :uncompiled_markdown, :string
      field :compiled_html, :string
      field :is_author, :boolean
      field :submission_date, Ecto.DateTime
      field :slug, :string
      field :votes, :integer
      field :score, :float
      field :status, :string

      timestamps
    end

end
