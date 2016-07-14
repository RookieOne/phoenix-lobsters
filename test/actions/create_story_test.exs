defmodule PhoenixLobstersTest.Actions.CreateStory do
  use ExUnit.Case
  alias PhoenixLobsters.Actions.CreateStory
  import PhoenixLobsters.TestHelper

  @tag :actions
  @tag :story
  test "Stories can be created" do
    user = gen_temp_user()
    title = "Lobsters Knockoff IN ELIXIR :D"
    {:ok, story} = CreateStory.execute(title,user.id)
    assert story.title == title
  end

  @tag :actions
  @tag :story
  test "Stories cannot be created with bad users" do
    title = "Totally great submission"
    {:error, errors} = CreateStory.execute( title, -42)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:author, "does not exist"}
  end

  @tag :actions
  @tag :story
  test "Stories cannot be created without users" do
    title = "Totally great submission"
    {:error, errors} = CreateStory.execute( title, nil)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:user_id, "can't be blank"}
  end

  @tag :actions
  @tag :story
  test "Stories cannot be created without titles" do
    user = gen_temp_user()
    title = nil
    {:error, errors} = CreateStory.execute(title, user.id)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:title, "can't be blank"}
  end
end