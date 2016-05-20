defmodule PhoenixLobsters.PageController do
  use PhoenixLobsters.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
