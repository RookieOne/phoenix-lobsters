defmodule PhoenixLobsters.AuthenticationController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobster.Actions.RegisterUser

  def register(conn, %{ "display_name" => display_name, "email" => email, "password" => password }) do
    case RegisterUser.execute(display_name, email, password) do
      {:ok,user} ->
        conn
        |> put_status(201)
        |> render("register.json", user: user)
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

end