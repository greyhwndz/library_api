defmodule LibraryApiWeb.AuthorView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/authors/:id"
  attributes [:first, :last]

  has_many :books,
    serializer: LibraryApiWeb.BookView,
    identifiers: :when_included,
    links: [
      related: "/api/authors/:id/books"
    ]
end
