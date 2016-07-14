defmodule PhoenixLobsters.CommentController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobsters.Actions.CreateCommentOnStory

  def create(conn, %{ "comment" => %{ "content" => content, "story_id" => story_id, "comment_id" => comment_id } }) do
    case conn |> get_session(:current_user) do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in to submit comments.")
        |> redirect(to: "/stories/#{story_id}")
      user_id ->
        case CreateCommentOnStory.execute(user_id, content, story_id, comment_id) do
          {:ok,comment} ->
            conn
            |> redirect(to: "/stories/#{story_id}")
          {:error, message} ->
            conn
            |> put_flash(:error, message)
            |> redirect(to: "/stories/#{story_id}")
        end    
    end
  end

  def create(conn, %{ "comment" => %{ "content" => content, "story_id" => story_id} }) do
    create(conn, %{ "comment" => %{ "content" => content, "story_id" => story_id, "comment_id" => nil } })
  end
end