defmodule HelloPhoenix.StoryView do
  use HelloPhoenix.Web, :view

  def render( "index.json" , %{stories: stories} ) do
  	Enum.map( stories, fn s -> %{id: s.id, title: s.title} end )
  end
end
