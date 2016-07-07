defmodule PhoenixLobsters.RegistrationController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobsters.Repo
  alias PhoenixLobsters.Story
  alias PhoenixLobsters.Actions.RegisterUser

  @moduledoc """
  Controller for registration routes
  """

  def new(conn, _params) do
    conn
    |> render("new.html")
  end

  def create(conn, %{ "register" => %{
      "display_name" => display_name,
      "email" => email,
      "password" => password
    }}) do

    case RegisterUser.execute(display_name, email, password) do
      {:error, errors} ->
        conn
        |> put_flash(:error, "Sorry, we couldn't register you")
        |> render("new.html", errors: errors)
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:success, "Registration successful")
        |> redirect(to: "/")
    end
  end

end