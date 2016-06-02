defmodule PhoenixLobsters.Api.AuthenticationView do
  use PhoenixLobsters.Web, :view

  def render("success.json" , %{user: user}) do
    %{ id: user.id, email: user.email }
  end

end
