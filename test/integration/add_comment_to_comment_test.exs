defmodule PhoenixLobsters.Integration.AddCommentToCommentTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.TestHelper
  import PhoenixLobsters.IntegrationHelper
  use QuickAlias, PhoenixLobsters

  hound_session

  setup do
    current_window_handle |> maximize_window
    {:ok, user} = login_user()
    story = add_story!()
    
    navigate_to("/stories/#{story.id}")
    
    comment = add_comment!(story: story, content: "Super special comment")

    {:ok, user: user, story: story, comment: comment}
  end

  @tag :integration
  test "As a user, I want to add a comment to a comment", %{ user: user, story: story, comment: comment } do
    navigate_to("/stories/#{story.id}")

    assert current_path == "/stories/#{story.id}"

    reply_button = find_element( :link_text, "reply" )
    click(reply_button)

    fill_field({:id, "comment-body-#{comment.id}"}, "Super special comment reply")
    submit_element({:id, "submit-comment-on-#{comment.id}"})

    assert 2 == length(find_all_elements(:class, "story-comment"))

    reply_comment = find_all_elements(:class, "story-comment")
    |> Enum.map(fn e -> find_within_element(e, :tag, :div) end)
    |> Enum.map(fn e -> inner_text(e) end)
    |> Enum.filter(fn txt -> Regex.match?(~r/Super special comment reply/, txt) end)
    |> hd

    assert reply_comment != nil
  end

end
