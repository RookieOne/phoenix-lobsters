defmodule PhoenixLobster.Story do
	use PhoenixLobsters.Web, :model

    @moduledoc """
    The Story module is responsible for stories submitted to the Phoenix Lobster.
    """

    schema "stories" do

      field :title, :string
      field :url, :string
      field :uncompiled_markdown, :string
      field :compiled_html, :string
      field :is_author, :boolean, default: false
      field :submission_date, Ecto.DateTime
      field :slug, :string
      field :votes, :integer
      field :score, :float
      field :status, :string

      belongs_to :author, PhoenixLobster.User, foreign_key: :user_id

      timestamps
    end

    @required_fields ~w( title user_id )
    @optional_fields ~w( url uncompiled_markdown compiled_html is_author submission_date )

    def changeset( model, params \\ :empty ) do
    	model
    	|> cast( params, @required_fields, @optional_fields )
      |> Ecto.Changeset.assoc_constraint(:author)
    end

end
