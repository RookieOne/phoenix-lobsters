defmodule PhoenixLobsters.Comment do
  use PhoenixLobsters.Web, :model

  @moduledoc """
    The Comment module is responsible for comments submitted to the Phoenix Lobster.

    Comments must have a parent story and author, as well as content.
    Parent comments are optional--we'll figure that out later.
    """

  schema "comments" do
    field :slug, :string
    field :compiled_html, :string
    field :uncompiled_description, :string
    field :status, :string

    belongs_to :author, PhoenixLobsters.User, foreign_key: :user_id
    belongs_to :story, PhoenixLobsters.Story
    belongs_to :comment, PhoenixLobsters.Comment

    timestamps
  end

  @required_fields ~w( slug uncompiled_description compiled_html author story)
  @optional_fields ~w( comment status)

  def changeset( mode, params \\ :empty ) do
    model
    |> cast( params, @required_fields, @optional_fields )
    |> Ecto.Changeset.assoc_constraint(:author)
    |> Ecto.Changeset.assoc_constraint(:story)
  end

end