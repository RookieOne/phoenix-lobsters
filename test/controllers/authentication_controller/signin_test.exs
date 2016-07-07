defmodule PhoenixLobsters.AuthenticationController.SigninTest do
  use PhoenixLobsters.ConnCase
  import PhoenixLobsters.TestHelper

  @tag :api
  @tag :authentication
  test "POST /api/signin - signins user", %{conn: conn} do
    {:ok, user} = add_user(email: "tony@stark.com", password: "iamironman")

    conn = post conn, "/api/signin", %{ email: "tony@stark.com", password: "iamironman" }

    assert conn.status == 200

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["id"] == user.id
    assert json["email"] == "tony@stark.com"
  end

  @tag :api
  @tag :authentication
  test "POST /api/signin - returns error if bad password", %{conn: conn} do
    {:ok, _} = add_user(email: "tony@stark.com", password: "iamironman")

    conn = post conn, "/api/signin", %{ email: "tony@stark.com", password: "badpassword" }

    assert conn.status == 401

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["message"] == "Email and/or password invalid"
  end

  @tag :api
  @tag :authentication
  test "POST /api/signin - returns error if bad email", %{conn: conn} do
    {:ok, _} = add_user(email: "tony@stark.com", password: "iamironman")

    conn = post conn, "/api/signin", %{ email: "pepper@stark.com", password: "iamironman" }

    assert conn.status == 401

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["message"] == "Email and/or password invalid"
  end

  @tag :api
  @tag :authentication
  test "POST /api/signin - returns error if missing email", %{conn: conn} do
    {:ok, _} = add_user(email: "tony@stark.com", password: "iamironman")

    conn = post conn, "/api/signin", %{ password: "iamironman" }

    assert conn.status == 400

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["message"] == "Signin requires email and password"
  end

  @tag :api
  @tag :authentication
  test "POST /api/signin - returns error if missing password", %{conn: conn} do
    {:ok, _} = add_user(email: "tony@stark.com", password: "iamironman")

    conn = post conn, "/api/signin", %{ email: "tony@stark.com" }

    assert conn.status == 400

    {:ok, json} = Poison.Parser.parse(conn.resp_body)

    assert json["message"] == "Signin requires email and password"
  end

end