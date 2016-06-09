defmodule PhoenixLobsters.Integration.SigninTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobster.TestHelper

  hound_session

  test "As a user, I want to sign in" do
    navigate_to("/signin")

    {:ok,user} = add_user(display_name: "Ironman", password: "password")

    fill_field({:id, "signin_email"}, user.email)
    fill_field({:id, "signin_password"}, "password")
    submit_element({:name, "signin"})

    assert current_path == "/"

    element = find_element(:id, "header-current-user-name")

    assert user.display_name == element |> inner_html
  end


end