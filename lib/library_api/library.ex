defmodule LibraryApi.Library do
  alias LibraryApi.Repo
  alias LibraryApi.Library.Author
  import Ecto.Query;

  def list_authors, do: Repo.all(Author)

  def search_authors(search_term) do
    search_term = String.downcase(search_term)

    Author
    |> where([a], like(fragment("lower(?)", a.first), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.last), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def get_author!(id), do: Repo.get!(Author, id)

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert
  end

  def update_author(%Author{} = model, attrs \\ %{}) do
    model
    |> Author.changeset(attrs)
    |> Repo.update
  end

  def delete_author(%Author{} = model), do: Repo.delete(model)
end
