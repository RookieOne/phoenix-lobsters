defmodule PhoenixLobsters.Actions.CreateTag do
  alias PhoenixLobsters.Tag
  alias PhoenixLobsters.Repo

  @moduledoc """
  The CreateTag module is for handling the "create a tag" action in PL.

  Usage:
    execute( title, description )
  """

  def execute( title, description ) do
    changeset = Tag.changeset( %Tag{}, %{ title: title, description: description} )
    case Repo.insert(changeset) do
      {:ok, tag} -> {:ok, tag}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end

end