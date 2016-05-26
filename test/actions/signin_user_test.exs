defmodule PhoenixLobsterTest.Actions.SiginUserTest do
  use ExUnit.Case
  alias PhoenixLobster.Actions.SigninUser
  import PhoenixLobster.TestHelper

  @tag :actions
  @tag :user
  @tag :authentication
  test "Signin user should return user" do
    {:ok, user} = add_user("tony3@stark.com", password: "iamironman")

    {:ok, signedin_user} = SigninUser.execute("tony3@stark.com", "iamironman")
    
    assert signedin_user.id == user.id
    assert signedin_user.email == "tony3@stark.com"
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Signin user should return error if password is wrong" do
    {:ok, _} = add_user("tony2@stark.com", password: "iamironman")

    {:error, message} = SigninUser.execute("tony2@stark.com", "wrongpassword")
    
    assert message == "Email and/or password invalid"
  end

end