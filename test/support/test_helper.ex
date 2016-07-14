defmodule PhoenixLobsters.TestHelper do
  alias PhoenixLobsters.Actions.RegisterUser
  alias PhoenixLobsters.Actions.CreateStory

  @moduledoc """
  Helper functions for testing PhoenixLobsters
  """

  def add_user(opts \\ %{}) do
    display_name = opts[:display_name] || "Ironman"
    email = opts[:email] || gen_fake_email("tony")
    password = opts[:password] || "iamironman"
    RegisterUser.execute(display_name, email, password)
  end

  def add_user!(opts \\ %{}) do
    {:ok, user} = add_user(opts)
    user
  end

  def add_story(opts \\ %{}) do
    user = opts[:user] || add_user!
    user_id = opts[:user_id] || user.id
    url = opts[:url] || "http://www.example.com"
    title = opts[:title] || ":("
    CreateStory.execute(title, user_id, url)
  end

  def add_story!(opts \\ %{}) do
    {:ok, story} = add_story(opts)
    story
  end

  def gen_fake_email( basename, domain \\ "example.com") do
    basename <> :base64.encode( :crypto.strong_rand_bytes(8)) <> "@" <> domain
  end

  def gen_temp_user( display_name \\ "Ironman", password \\ "iamironman", basename \\ "tony", domain \\ "example.com") do
    {:ok, user} = RegisterUser.execute( display_name,
                                        gen_fake_email( basename, domain ),
                                        password)
    user
  end

end