defmodule PhoenixLobster.Actions.CreateStory do
	alias PhoenixLobster.Story	
	alias PhoenixLobsters.Repo

	@moduledoc """
	The CreateStory module is for handling the "create a story" action in PL.
	"""

	def execute( title ) do
		changeset = Story.changeset( %Story{}, %{title: title} )
		case Repo.insert(changeset) do
			{:ok, story} -> {:ok, story}
			{:error, changeset} -> {:error, changeset.errors}
		end
		
	end
end