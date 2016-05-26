defmodule PhoenixLobsters.Router do
  use PhoenixLobsters.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixLobsters do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixLobsters do
    pipe_through :api

    post "/register", AuthenticationController, :register

    get "/stories", StoryController, :index
  end
end
