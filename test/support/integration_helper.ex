defmodule PhoenixLobsters.IntegrationHelper do
  import PhoenixLobsters.TestHelper
  use Hound.Helpers

  @moduledoc """
  Helper functions for integration tests
  """

  def login_user do
    {:ok, user} = add_user(display_name: "Ironman", password: "password")
    navigate_to("/signin")

    fill_field({:id, "signin_email"}, user.email)
    fill_field({:id, "signin_password"}, "password")
    submit_element({:name, "signin"})
    {:ok, user}
  end

  def get_flash_error_message() do
    find_element(:class, "flash-error") |> inner_text
  end

  def get_flash_success_message() do
    find_element(:class, "flash-success") |> inner_text
  end

end