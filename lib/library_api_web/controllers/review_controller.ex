defmodule LibraryApiWeb.ReviewController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.Review

  def index(conn, _params) do
    reviews = Library.list_reviews

    render(conn, "index.json-api", data: reviews)
  end

  def reviews_for_book(conn, %{"book_id" => book_id}) do
    reviews = Library.list_reviews_for_book(book_id)

    render(conn, "index.json-api", data: reviews)
  end

  def show(conn, %{"id" => id}) do
    review = Library.get_review!(id)

    render(conn, "show.json-api", data: review)
  end

  def create(conn, %{"data" => data = %{"type" => "reviews", "attributes" => _review_params}}) do
    data = JaSerializer.Params.to_attributes data

    case Library.create_review(data) do
      {:ok, %Review{} = review} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.review_path(conn, :show, review))
        |> render("show.json-api", data: review)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(LibraryApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "reviews", "attributes" => _review_params}}) do
    review = Library.get_review!(id)
    data = JaSerializer.Params.to_attributes data

    case Library.update_review(review, data) do
      {:ok, %Review{} = review} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.review_path(conn, :show, review))
        |> render("show.json-api", data: review)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(LibraryApiWeb.ErrorView, "400.json-api", changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Library.get_review!(id)

    with {:ok, %Review{}} <- Library.delete_review(review) do
      send_resp(conn, :no_content, "")
    end
  end

end
