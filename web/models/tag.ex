defmodule PhoenixLobsters.Tag do
  use PhoenixLobsters.Web, :model

  @moduledoc """
    The Tag module is responsible for the tags that appear on submissions.

    Tags are associated through the StoryTags models.
    """

  schema "tags" do
    field :title, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w( title description )
  @optional_fields ~w( )

  def changeset( model, params \\ :empty ) do
    model
    |> cast( params, @required_fields, @optional_fields )
    |> unique_constraint(:title)
  end

end