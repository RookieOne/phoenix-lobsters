defmodule HelloPhoenix.StoryController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
  	stories = HelloPhoenix.Repo.all( PhoenixLobster.Story )
    render conn, "index.json", stories: stories
  end
end