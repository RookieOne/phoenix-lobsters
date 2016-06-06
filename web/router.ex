defmodule PhoenixLobsters.Router do
  use PhoenixLobsters.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixLobster.Plugs.AuthenticateUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixLobsters do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    get "/signin", SessionController, :new
    post "/signin", SessionController, :create
    get "/signout", SessionController, :destroy
    
    get "/stories/submit", StoryController, :new
    post "/stories/submit", StoryController, :create
    get "/stories/:story_id", StoryController, :view
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixLobsters.Api do
    pipe_through :api

    post "/register", AuthenticationController, :register
    post "/signin", AuthenticationController, :signin

    get "/stories", StoryController, :index
  end
end
