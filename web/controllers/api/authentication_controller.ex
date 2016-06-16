defmodule PhoenixLobsters.Api.AuthenticationController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobsters.Actions.RegisterUser
  alias PhoenixLobsters.Actions.SigninUser

  def register(conn, %{ "display_name" => display_name, "email" => email, "password" => password }) do
    case RegisterUser.execute(display_name, email, password) do
      {:ok,user} ->
        conn
        |> put_status(201)
        |> render("success.json", user: user)
      {:error,errors} ->
        conn
        |> put_status(400)
        |> json(%{ errors: errors })
    end
  end

  def register(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{ message: "Registration requires display_name, email, and password" })
  end

  def signin(conn, %{ "email" => email, "password" => password }) do
    case SigninUser.execute(email, password) do
      {:ok,user} ->
        conn
        |> put_status(200)
        |> render("success.json", user: user)
      {:error,message} ->
        conn
        |> put_status(401)
        |> json(%{ message: message })
    end
  end

  def signin(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{ message: "Signin requires email and password" })
  end

end