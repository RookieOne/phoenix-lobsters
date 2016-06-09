defmodule PhoenixLobster.IntegrationHelper do
  import PhoenixLobster.TestHelper
  use Hound.Helpers

  def login_user() do    
    {:ok, user} = add_user(display_name: "Ironman", password: "password")
    navigate_to("/signin")

    fill_field({:id, "signin_email"}, user.email)
    fill_field({:id, "signin_password"}, "password")
    submit_element({:name, "signin"})
    {:ok, user}
  end
end