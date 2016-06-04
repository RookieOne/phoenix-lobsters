defmodule PhoenixLobsters.StoryController do
  use PhoenixLobsters.Web, :controller  
  alias PhoenixLobster.Actions.CreateStory

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{ "submit" => %{ "title" => title, "url" => url } }) do
    case conn |> get_session(:current_user) do
      nil ->
              conn
              |> put_flash(:error, "You must be logged in to submit stories.")
              |> render("new.html")
      user_id ->
                case CreateStory.execute(title, user_id) do
                  {:error, message} ->
                                      conn
                                      |> put_flash(:error, message)
                                      |> render("new.html")

                  {:ok, _} ->
                    conn
                    |> put_flash(:success, "Story submitted!")
                    |> redirect(to: "/")
                end
    end  
  end
  def create(conn, _params) do
    conn
    |> put_flash(:error, "Title and URL are required.")
    |> render("new.html")
  end  
end