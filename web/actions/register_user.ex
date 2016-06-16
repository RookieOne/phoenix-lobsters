defmodule PhoenixLobsters.Actions.RegisterUser do
  alias PhoenixLobsters.User
  alias PhoenixLobsters.Repo
  import Comeonin.Bcrypt
  import PhoenixLobsters.Errors

  @moduledoc """
    Register user requires a non empty display name, email, and password.
    Create a user record and hashes the password.

    Usage:
      execute(display_name, email, password)
  """
  def execute("", _, _), do: {:error, ["Display name can't be blank"]}
  def execute(_, "", _), do: {:error, ["Email can't be blank"]}
  def execute(_, _, ""), do: {:error, ["Password can't be blank"]}
  def execute(display_name, email, password) do
    changeset = User.changeset(%User{}, %{
      display_name: display_name,
      email: email,
      hashed_password: hashpwsalt(password)
    })

    case Repo.insert(changeset) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, get_error_messages(changeset)}
    end
  end

end