defmodule PhoenixLobsters.CommentController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobsters.Actions.CreateCommentOnStory

  @moduledoc """
  Controller for comments  
  """

  def create(conn, %{ "comment" => %{ "content" => content, "story_id" => story_id } }) do
    user = conn.assigns[:current_user]
    case CreateCommentOnStory.execute(user.id, content, story_id) do
      {:ok, comment} ->
        conn
        |> redirect(to: "/stories/#{story_id}")
    end
  end

end