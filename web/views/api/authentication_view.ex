defmodule PhoenixLobsters.Api.AuthenticationView do
  use PhoenixLobsters.Web, :view

  @moduledoc """
  View for the authentication api endpoint  
  """

  def render("success.json" , %{user: user}) do
    %{ id: user.id, email: user.email }
  end

end
