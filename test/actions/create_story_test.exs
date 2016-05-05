defmodule PhoenixLobsterTest.Actions.CreateStory do
	use ExUnit.Case
	alias PhoenixLobster.Actions.CreateStory
	alias PhoenixLobster.Story

	@tag :actions
	@tag :story
	test "Stories can be created" do
		title = "Lobsters Knockoff IN ELIXIR :D"
		{:ok, story} = CreateStory.execute( title )
		assert story.title == title
	end
end