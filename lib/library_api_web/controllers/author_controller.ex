defmodule LibraryApiWeb.AuthorController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.Author

  def index(conn, %{ "filter" => %{ "query" => search_term } }) do
    authors = Library.search_authors(search_term)

    render(conn, "index.json-api", data: authors)
  end

  def index(conn, _params) do
    authors = Library.list_authors()

    render(conn, "index.json-api", data: authors)
  end

  def create(conn, %{ "data" => _data = %{ "type" => "authors", "attributes" => author_params }}) do
    with {:ok, %Author{} = author} <- Library.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json-api", data: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Library.get_author!(id)

    conn
    |> render("show.json-api", data: author)
  end

  def update(conn, %{ "id" => id, "data" => _data = %{ "type" => "authors", "attributes" => author_params }}) do
    author = Library.get_author!(id)

    with {:ok, %Author{} = author} <- Library.update_author(author, author_params) do
      conn
      |> render("show.json-api", data: author)
    end
  end

  def delete(conn, %{ "id" => id }) do
    author = Library.get_author!(id)

    with {:ok, %Author{}} <- Library.delete_author(author) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end
