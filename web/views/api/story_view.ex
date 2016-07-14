defmodule PhoenixLobsters.Api.StoryView do
  use PhoenixLobsters.Web, :view

  @moduledoc """
  View for the /stories api endpoint  
  """

  def render( "index.json" , %{stories: stories} ) do
    Enum.map( stories, fn s -> %{id: s.id, title: s.title} end )
  end
end
