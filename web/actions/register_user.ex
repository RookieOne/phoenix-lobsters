defmodule PhoenixLobster.Actions.RegisterUser do
  alias PhoenixLobster.User
  alias PhoenixLobsters.Repo
  import Comeonin.Bcrypt

  @moduledoc """
    Register user requires a non empty display name, email, and password.
    Create a user record and hashes the password.
  """
  def execute("", _, _), do: {:error, [display_name: "can't be blank"]}
  def execute(_, "", _), do: {:error, [email: "can't be blank"]}
  def execute(_, _, ""), do: {:error, [password: "can't be blank"]}
  def execute(display_name, email, password) do
    changeset = User.changeset(%User{}, %{
      display_name: display_name,
      email: email,
      hashed_password: hashpwsalt(password)
    })

    case Repo.insert(changeset) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end

end