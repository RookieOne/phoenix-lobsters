defmodule PhoenixLobsters.Integration.RegistrationTest do
  use ExUnit.Case
  use Hound.Helpers
  import PhoenixLobsters.TestHelper

  hound_session

  @tag :integration
  test "As a vistor, I want to register" do
    navigate_to("/registration/new")

    email = gen_fake_email("example.com")
    fill_field({:id, "register_display_name"}, "Ironman")
    fill_field({:id, "register_email"}, email)
    fill_field({:id, "register_password"}, "iamironman")
    submit_element({:name, "register"})

    assert current_path == "/"
    assert "Ironman" == inner_text({:id, "header-current-user-name"})
    assert "Registration successful" = inner_text({:id, "flash-success"})
  end

  @tag :integration
  test "As a visitor, when I register with an email that is already used then I should see an error message" do
    navigate_to("/registration/new")

    email = gen_fake_email("example.com")
    add_user(email: email)
    fill_field({:id, "register_display_name"}, "Ironman")
    fill_field({:id, "register_email"}, email)
    fill_field({:id, "register_password"}, "iamironman")
    submit_element({:name, "register"})

    assert current_path == "/registration"

    assert "Sorry, we couldn't register you" == inner_text({:id, "flash-error"})

    error_message = find_element(:class, "errors") 
      |> find_all_within_element(:tag, "li") 
      |> Enum.at(0)
      |> inner_text

    assert "Email has already been taken" == error_message
  end

end