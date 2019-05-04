defmodule LibraryApiWeb.BookView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/books/:id"
  attributes [:title, :isbn, :publish_date]

  has_one :author,
    serializer: LibraryApiWeb.AuthorView,
    identifiers: :when_included,
    links: [
      related: "/api/books/:id/author"
    ]
end
