defmodule PhoenixLobsters.Errors do
  
  def get_error_messages(changeset) do
    for {field_name,message} <- changeset.errors do
      field = field_name 
        |> to_string
        |> String.replace("_", " ")
        |> String.capitalize
      "#{field} #{message}"
    end
  end

end