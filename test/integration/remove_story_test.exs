defmodule PhoenixLobsters.Integration.RemoveStoryTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.TestHelper
  import PhoenixLobsters.IntegrationHelper

  hound_session

  setup do
    current_window_handle |> maximize_window
    {:ok, user} = login_user()
    story = add_story!(user: user)
    {:ok, user: user, story: story}
  end

  @tag :integration
  test "As the author of a story, I want to remove my story", %{ user: user, story: story } do
    navigate_to("/stories/#{story.id}")

    submit_element({:id, "remove_story"})

    assert get_flash_success_message() == "Story is removed"
  end

end