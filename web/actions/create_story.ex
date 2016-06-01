defmodule PhoenixLobster.Actions.CreateStory do
  alias PhoenixLobster.Story  
  alias PhoenixLobsters.Repo

  @moduledoc """
  The CreateStory module is for handling the "create a story" action in PL.
  """
  
  def execute( title, author ) do
    changeset = Story.changeset( %Story{}, %{title: title, user_id: author} )
    case Repo.insert(changeset) do
      {:ok, story} -> {:ok, story}
      {:error, changeset} -> {:error, changeset.errors}
    end
    
  end
end