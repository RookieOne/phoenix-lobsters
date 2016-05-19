defmodule PhoenixLobsters.StoryView do
  use PhoenixLobsters.Web, :view

  def render( "index.json" , %{stories: stories} ) do
  	Enum.map( stories, fn s -> %{id: s.id, title: s.title} end )
  end
end
