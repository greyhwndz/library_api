defmodule LibraryApiWeb.ReviewView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/reviews/:id"
  attributes [:user, :body, :created_at]

  def attributes(review, conn) do
    review
    |> Map.put(:created_at, review.inserted_at)
    |> super(conn)
  end

  has_one :book,
    serializer: LibraryApiWeb.BookView,
    identifiers: :when_included,
    links: [
      related: "/api/reviews/:id/book"
    ]
end
