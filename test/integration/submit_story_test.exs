defmodule PhoenixLobsters.Integration.SubmitStoryTest do
  use ExUnit.Case
  use Hound.Helpers  
  import PhoenixLobster.IntegrationHelper

  hound_session

  setup do
    {:ok, user} = login_user()
    {:ok, user: user}
  end

  @tag :integration
  test "As a user, I want to submit a story", %{ user: user } do

    test_title = "Alta-vista"
    test_url = "http://www.google.com/"
    test_description = "# ZOMG"


    # navigate to the story submission page
    element = find_element(:id, "header-submit-story")    
    click( element )
    assert current_path == "/stories/new"

    # we fill in the form
    fill_field({:id, "submit_title"}, test_title)
    fill_field({:id, "submit_url"}, test_url)
    fill_field({:id, "submit_uncompiled_markdown"}, test_description)
    submit_element({:name, "submit"})

    # and we check to make sure the page is correctly formed
    assert Regex.match?( ~r/^\/stories\/\d+$/u,  current_path )

    rendered_title = find_element(:id, "story-view-title")
    assert test_title == rendered_title |> visible_text

    rendered_url = rendered_title |> attribute_value( :href )
    assert rendered_url == test_url

    rendered_author = find_element(:id, "story-view-author")
    assert user.display_name == rendered_author |> visible_text

    rendered_description = find_element(:id, "story-view-description")
    assert "<h1>ZOMG</h1>" == rendered_description |> inner_html |> String.strip

  end
end