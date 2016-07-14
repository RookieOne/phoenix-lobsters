defmodule Mix.Tasks.PhoenixLobsters.Hello do
  use Mix.Task

  @moduledoc """
  Example on how to do a custom mix task
  """

  @shortdoc "Have Mix say Hi to us"

  def run(_) do
    IO.puts "Hello from the Magical Land of Mix"
  end

end