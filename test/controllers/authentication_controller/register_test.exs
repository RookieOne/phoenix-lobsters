defmodule PhoenixLobsters.AuthenticationController.RegisterTest do
  use PhoenixLobsters.ConnCase

  @tag :api
  @tag :authentication
  test "POST /api/register - creates user", %{conn: conn} do
    display_name = "Ironman"
    email = "tony@stark.com"
    password = "iamironman"

    conn = post conn, "/api/register", %{ display_name: display_name, email: email, password: password }

    assert conn.status == 201

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["id"] != nil
    assert json["email"] != nil
  end

  @tag :api
  @tag :authentication
  test "POST /api/register - returns error if missing display_name", %{conn: conn} do
    email = "tony@stark.com"
    password = "iamironman"

    conn = post conn, "/api/register", %{ email: email, password: password }

    assert conn.status == 400

    {:ok, json} = Poison.Parser.parse(conn.resp_body)
    assert json["message"] == "Registration requires display_name, email, and password"
  end

  @tag :api
  @tag :authentication
  test "POST /api/register - returns error if missing email", %{conn: conn} do
    display_name = "Ironman"
    password = "iamironman"

    conn = post conn, "/api/register", %{ display_name: display_name, password: password }

    assert conn.status == 400

    {:ok, json} = Poison.Parser.parse(conn.resp_body)
    assert json["message"] == "Registration requires display_name, email, and password"
  end

  @tag :api
  @tag :authentication
  test "POST /api/register - returns error if missing password", %{conn: conn} do
    display_name = "Ironman"
    email = "tony@stark.com"

    conn = post conn, "/api/register", %{ display_name: display_name, email: email }

    assert conn.status == 400

    {:ok, json} = Poison.Parser.parse(conn.resp_body)
    assert json["message"] == "Registration requires display_name, email, and password"
  end

end
