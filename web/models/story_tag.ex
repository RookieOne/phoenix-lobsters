defmodule PhoenixLobsters.StoryTag do
  use PhoenixLobsters.Web, :model

  @moduledoc """
    The StoryTag module is responsible for the joining stories and tags.
    """

  schema "story_tags" do
    belongs_to :story, PhoenixLobsters.Story
    belongs_to :tag, PhoenixLobsters.Tag

    timestamps
  end

  @required_fields ~w( story_id tag_id)
  @optional_fields ~w( )

  def changeset( model, params \\ :empty ) do
    model
    |> cast( params, @required_fields, @optional_fields )
    |> Ecto.Changeset.assoc_constraint(:story)
    |> Ecto.Changeset.assoc_constraint(:tags)
  end

end