defmodule PhoenixLobster.TestHelper do
  alias PhoenixLobster.User
  alias PhoenixLobsters.Repo
  alias PhoenixLobster.Actions.RegisterUser
  import Comeonin.Bcrypt

  def add_user(opts \\ %{}) do
    display_name = opts[:display_name] || "Ironman"
    email = opts[:email] || gen_fake_email("tony")
    password = opts[:password] || "iamironman"
    RegisterUser.execute(display_name, email, password)
  end

  # def add_user(email, opts \\ %{}) do
  #   User.changeset(%User{}, %{
  #     display_name: opts[:display_name] || "User",
  #     email: email,
  #     hashed_password: hashpwsalt(opts[:password] || "password")
  #   }) |> Repo.insert
  # end

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
