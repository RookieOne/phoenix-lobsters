defmodule PhoenixLobsters.StoryController do
  use PhoenixLobsters.Web, :controller  
  alias PhoenixLobsters.Actions.CreateStory
  alias PhoenixLobsters.Story

  def new(conn, _params) do
    render conn, "new.html"
  end

  def show(conn, story_id: nil) do
    conn |> redirect(to: "/")
  end
  def show(conn, %{"story_id" => story_id}) do
    story = Story 
    |> Repo.get( story_id ) 
    |> Repo.preload([:author, :comments, comments: :author])

    render conn, "show.html", story: story
  end

  def create(conn, %{ "submit" => %{ "title" => title, "url" => url,"uncompiled_markdown" => uncompiled_markdown, "is_author" => is_author} }) do
    case conn |> get_session(:current_user) do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in to submit stories.")
        |> render("new.html")
      user_id ->
        case CreateStory.execute(title, user_id, url, uncompiled_markdown, is_author) do
          {:error, message} ->
            conn
            |> put_flash(:error, message)
            |> render("new.html")

          {:ok, story } ->
            conn
            |> put_flash(:success, "Story submitted!")
            |> redirect(to: "/stories/#{ story |> Map.fetch!(:id) |> Integer.to_string}" )
        end
    end
  end
  def create(conn, _params) do
    conn
    |> put_flash(:error, "Title and URL are required.")
    |> render("new.html")
  end

end