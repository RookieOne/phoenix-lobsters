defmodule PhoenixLobstersTest.Actions.RemoveStory do
  use ExUnit.Case
  alias PhoenixLobsters.Actions.CreateCommentOnStory
  import PhoenixLobsters.TestHelper
  use QuickAlias, PhoenixLobsters

  test "Remove story should change its status" do
    story = add_story!
    
    {:ok, story} = RemoveStory.execute(story)

    assert story.status == "removed"
  end

end