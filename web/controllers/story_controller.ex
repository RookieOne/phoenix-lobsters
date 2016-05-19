defmodule PhoenixLobsters.StoryController do
  use PhoenixLobsters.Web, :controller

  def index(conn, _params) do
  	stories = PhoenixLobsters.Repo.all( PhoenixLobster.Story )
    render conn, "index.json", stories: stories
  end
end