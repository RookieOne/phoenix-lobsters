defmodule PhoenixLobsters.PageController do
  use PhoenixLobsters.Web, :controller
  alias PhoenixLobsters.Repo
  alias PhoenixLobsters.Story

  @moduledoc """
  Controller for pages
  """

  def index(conn, _params) do
    stories = Story |> Repo.all |> Repo.preload( :author )
    render conn, "index.html", stories: stories
  end
end
