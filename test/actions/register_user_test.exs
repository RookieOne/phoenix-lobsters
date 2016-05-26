defmodule PhoenixLobsterTest.Actions.RegisterUser do
  use ExUnit.Case
  alias PhoenixLobster.Actions.RegisterUser
  import Comeonin.Bcrypt

  @tag :actions
  @tag :user
  @tag :authentication
  test "Register user should create a user" do
    display_name = "Ironman"
    email = "tony@stark.com"
    password = "iamironman"
    
    {:ok, user} = RegisterUser.execute(display_name, email, password)
    
    assert user.email == "tony@stark.com"
    assert user.hashed_password != nil
    assert user.hashed_password != "iamironman"

    assert checkpw("iamironman", user.hashed_password)
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Register user requires a password" do
    display_name = "Ironman"
    email = "tony@stark.com"
    password = ""
    
    {:error, message} = RegisterUser.execute(display_name, email, password)

    assert message == [password: "can't be blank"]
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Register user requires a email" do
    display_name = "Ironman"
    email = ""
    password = "iamironman"
    
    {:error, message} = RegisterUser.execute(display_name, email, password)

    assert message == [email: "can't be blank"]
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Register user requires a display name" do
    display_name = ""
    email = "tony@stark.com"
    password = "iamironman"
    
    {:error, message} = RegisterUser.execute(display_name, email, password)

    assert message == [display_name: "can't be blank"]
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Register user requires a proper display name" do
    display_name = "@ironman"
    email = "tony@stark.com"
    password = "iamironman"
    
    {:error, message} = RegisterUser.execute(display_name, email, password)

    assert message == [display_name: "has invalid format"]
  end
end