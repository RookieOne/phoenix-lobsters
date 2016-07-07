defmodule PhoenixLobsters.Actions.CreateStory do
  alias PhoenixLobsters.Story
  alias PhoenixLobsters.Repo

  @moduledoc """
  The CreateStory module is for handling the "create a story" action in PL.

  Usage:
    execute( title, author, url, uncompiled_markdown, is_author, submission_date )
  """

  def execute( title, author,  url \\ "", uncompiled_markdown \\ "", is_author \\ false, submission_date \\ :calendar.universal_time ) do
    changeset = Story.changeset( %Story{}, %{ title: title,
                                              user_id: author,
                                              url: url,
                                              uncompiled_markdown: uncompiled_markdown,
                                              compiled_html: Earmark.to_html( uncompiled_markdown ),
                                              is_author: is_author,
                                              submission_date: submission_date} )
    case Repo.insert(changeset) do
      {:ok, story} -> {:ok, story}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end

end