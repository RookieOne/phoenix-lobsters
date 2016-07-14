defmodule PhoenixLobsters.Integration.SubmitStoryTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.IntegrationHelper

  hound_session

  setup do
    current_window_handle |> maximize_window
    {:ok, user} = login_user()
    {:ok, user: user}
  end

  @tag :integration
  test "As a user, I want to submit a story", %{ user: user } do

    test_title = "Alta-vista"
    test_url = "http://www.google.com/"
    test_description = "# ZOMG"

    # navigate to the story submission page
    click({:id, "header-submit-story"})
    assert current_path == "/stories/new"

    # we fill in the form
    fill_field({:id, "submit_title"}, test_title)
    fill_field({:id, "submit_url"}, test_url)
    fill_field({:id, "submit_uncompiled_markdown"}, test_description)
    submit_element({:name, "submit"})

    # and we check to make sure the page is correctly formed
    assert Regex.match?( ~r/^\/stories\/\d+$/u,  current_path )

    assert test_title == visible_text({:id, "story-view-title"})
    assert test_url == attribute_value({:id, "story-view-title"}, :href )
    assert user.display_name == visible_text({:id, "story-view-author"})
    assert "<h1>ZOMG</h1>" == {:id, "story-view-description"} |> inner_html() |> String.strip
  end

end