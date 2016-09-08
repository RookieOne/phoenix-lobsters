defmodule PhoenixLobstersTest.Actions.CreateTag do
  use ExUnit.Case
  alias PhoenixLobsters.Actions.CreateTag
  import PhoenixLobsters.TestHelper

  setup do
    title = "test" <> gen_random_suffix()
    description = "this is a test tag"
    {:ok, title: title, description: description}
  end

  @tag :actions
  @tag :tag
  test "Tags can be created", %{title: title, description: description} do
    {:ok, tag} = CreateTag.execute(title, description)
    assert tag.title == title
    assert tag.description === description
  end

  @tag :actions
  @tag :tag
  test "Tags cannot be created without titles", %{title: title, description: description} do
    {:error, errors} = CreateTag.execute(nil, description)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:title, "can't be blank"}
  end

  @tag :actions
  @tag :tag
  test "Tags cannot be created without descriptions", %{title: title, description: description} do
    {:error, errors} = CreateTag.execute(title, nil)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:description, "can't be blank"}
  end

  @tag :actions
  @tag :tag
  test "Tags cannot be created using an existing name", %{title: title, description: description} do
    CreateTag.execute(title, description)
    
    {:error, errors} = CreateTag.execute(title, description)
    assert Enum.count(errors) == 1
    [error | _] = errors
    assert error == {:title, "has already been taken"}
  end
end