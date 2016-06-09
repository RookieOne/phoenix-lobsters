defmodule PhoenixLobsters.Integration.SigninTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobster.TestHelper

  hound_session

  setup do
    {:ok, user} = add_user(display_name: "Ironman", password: "password")
    {:ok, user: user}
  end

  test "As a user, I want to sign in", %{ user: user } do
    navigate_to("/signin")

    fill_field({:id, "signin_email"}, user.email)
    fill_field({:id, "signin_password"}, "password")
    submit_element({:name, "signin"})

    assert current_path == "/"

    element = find_element(:id, "header-current-user-name")

    assert user.display_name == element |> inner_html
  end

  test "As a user, when I signin with an incorrect email I should see an error message" do
    navigate_to("/signin")

    fill_field({:id, "signin_email"}, "bademail@bogus.com")
    fill_field({:id, "signin_password"}, "password")
    submit_element({:name, "signin"})

    assert current_path == "/signin"

    element = find_element(:id, "flash-error")

    assert "Email and/or password invalid" == element |> inner_html
  end

  test "As a user, when I signin with an incorrect password I should see an error message", %{ user: user } do
    navigate_to("/signin")

    fill_field({:id, "signin_email"}, user.email)
    fill_field({:id, "signin_password"}, "badpassword")
    submit_element({:name, "signin"})

    assert current_path == "/signin"

    element = find_element(:id, "flash-error")

    assert "Email and/or password invalid" == element |> inner_html
  end

end