defmodule PhoenixLobsters.AuthenticationView do
  use PhoenixLobsters.Web, :view

  def render("register.json" , %{user: user}) do
    %{ id: user.id, email: user.email }
  end

end
