defmodule PhoenixLobsters.Actions.RemoveStory do
  alias PhoenixLobsters.Story
  alias PhoenixLobsters.Repo
  import PhoenixLobsters.Errors

  @moduledoc """
  
  """

  def execute(story) do
    changeset = Story.changeset(story, %{ status: "removed" })

    case Repo.update(changeset) do
      {:ok, story} -> {:ok, story}
      {:error, changeset} -> {:error, get_error_messages(changeset)}
    end
  end

end