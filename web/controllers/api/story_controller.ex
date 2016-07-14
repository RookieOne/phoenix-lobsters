defmodule PhoenixLobsters.Api.StoryController do
  use PhoenixLobsters.Web, :controller

  @moduledoc """
  Controller for story api endpoint
  """

  def index(conn, _params) do
    stories = PhoenixLobsters.Repo.all( PhoenixLobsters.Story )
    render conn, "index.json", stories: stories
  end
end