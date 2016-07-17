defmodule PhoenixLobsters.Integration.AddCommentToStoryTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.TestHelper
  import PhoenixLobsters.IntegrationHelper

  hound_session

  setup do
    current_window_handle |> maximize_window
    {:ok, user} = login_user()
    story = add_story!()
    {:ok, user: user, story: story}
  end

  @tag :integration
  test "As a user, I want to add a comment to a story", %{ user: user, story: story } do
    navigate_to("/stories/#{story.id}")

    fill_field({:id, "comment_content"}, "Super special comment")
    submit_element({:id, "add_comment_to_story"})

    assert current_path == "/stories/#{story.id}/"

    assert 1 == length(find_all_elements(:class, "story-comment"))
  end

end
