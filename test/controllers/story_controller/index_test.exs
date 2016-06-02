defmodule PhoenixLobsters.StoryController.IndexTest do
  use PhoenixLobsters.ConnCase
  import PhoenixLobster.TestHelper

  test "GET /api/stories", %{conn: conn} do
    title = "this is a test story"
    user = gen_temp_user()
    PhoenixLobster.Actions.CreateStory.execute( title, user.id )

    conn = get conn, "/api/stories"
    assert conn.status == 200
    {:ok, json} = Poison.Parser.parse(conn.resp_body)
    assert Enum.count(json) == 1
    [ story | _ ] = json
    assert story["title"] == title
  end
end
