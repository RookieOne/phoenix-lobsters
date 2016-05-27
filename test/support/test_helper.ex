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

  def gen_fake_email( basename, domain \\ "example.com") do
    basename <> :base64.encode( :crypto.strong_rand_bytes(8)) <> "@" <> domain
  end

end
