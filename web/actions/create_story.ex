defmodule PhoenixLobster.Actions.CreateStory do

	@moduledoc """
	The CreateStory module is for handling the "create a story" action in PL.
	"""

	def execute( title ) do
		story = %PhoenixLobster.Story{ title: title}
		HelloPhoenix.Repo.insert(story)		
	end

end