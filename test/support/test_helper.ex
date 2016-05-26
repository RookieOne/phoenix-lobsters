defmodule PhoenixLobster.TestHelper do
  alias PhoenixLobster.User
  alias PhoenixLobsters.Repo
  import Comeonin.Bcrypt

  def add_user(email, opts \\ %{}) do
    User.changeset(%User{}, %{
      display_name: opts[:display_name] || "User",
      email: email,
      hashed_password: hashpwsalt(opts[:password] || "password")
    }) |> Repo.insert
  end

end