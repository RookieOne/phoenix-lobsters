defmodule PhoenixLobsters.Actions.SigninUser do
  alias PhoenixLobsters.User
  alias PhoenixLobsters.Repo
  import Comeonin.Bcrypt
  import Ecto.Query

  @moduledoc """
    Signin user requires a non empty email and password.
    Checks against User records for email and then checks hashed password.
  """
  # def execute("", _, _), do: {:error, [display_name: "can't be blank"]}
  # def execute(_, "", _), do: {:error, [email: "can't be blank"]}
  # def execute(_, _, ""), do: {:error, [password: "can't be blank"]}
  def execute(email, password) do
    user = User |> where([u], u.email == ^email) |> Repo.one

    case user do
      nil -> {:error, "Email and/or password invalid"}
      _ ->
        case checkpw(password, user.hashed_password) do
          true -> {:ok, user}
          false -> {:error, "Email and/or password invalid"}
        end
    end
  end

end