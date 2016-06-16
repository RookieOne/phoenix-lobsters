defmodule PhoenixLobstersTest.Actions.CreateCommentOnStory do
  use ExUnit.Case
  alias PhoenixLobsters.Actions.CreateCommentOnStory
  import PhoenixLobsters.TestHelper

  setup do
    user = add_user!()
    story = add_story!()
    {:ok, user: user, story: story}
  end

  @tag :actions
  @tag :comment
  test "Users can create a comment on a story", %{user: user, story: story} do
    test_markdown = "# Test"
    test_html = "<h1>Test</h1>"
    {:ok, comment} = CreateCommentOnStory.execute( user.id, test_markdown, story.id)

    # other assertions here
    assert test_html == comment.compiled_html |> String.strip
    assert test_markdown == comment.uncompiled_markdown
    assert user.id == comment.user_id
    assert story.id == comment.story_id
  end
end