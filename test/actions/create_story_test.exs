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

	@tag :actions
	@tag :story
	test "Stories cannot be created without titles" do		
		{:error, errors} = CreateStory.execute( nil )
		assert Enum.count(errors) == 1
		[ error | _] = errors
		assert error == {:title, "can't be blank" }
	end
end