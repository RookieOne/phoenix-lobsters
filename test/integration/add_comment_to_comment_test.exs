defmodule PhoenixLobsters.Integration.AddCommentToCommentTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.TestHelper
  import PhoenixLobsters.IntegrationHelper

  hound_session

  setup do
    current_window_handle |> maximize_window
    {:ok, user} = login_user()
    story = add_story!()
    
    navigate_to("/stories/#{story.id}")
   
    fill_field({:id, "comment_content"}, "Super special comment")
    submit_element({:id, "add_comment_to_story"})
    {:ok, user: user, story: story}
  end

  @tag :integration
  test "As a user, I want to add a comment to a comment", %{ user: user, story: story } do
    navigate_to("/stories/#{story.id}")

    assert current_path == "/stories/#{story.id}"

    reply_button = find_element( :link_text, "reply" )
    click(reply_button)
    
    comment_id = attribute_value(reply_button, :id)
    {comment_num, _} = Integer.parse(String.slice( comment_id, 8..-1))
    
    fill_field({:id, "comment-body-#{comment_num}"}, "Super special comment reply")
    submit_element({:id, "submit-comment-on-#{comment_num}"})

    assert 2 == length(find_all_elements(:class, "story-comment"))

    IO.inspect find_all_elements(:class, "story-comment")
    comment_element = find_element( :id, "comment-body-markup-#{comment_num+1}")
  end

end
