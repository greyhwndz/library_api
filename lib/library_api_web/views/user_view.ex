defmodule LibraryApiWeb.UserView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/api/users/:id"
  attributes [:email, :username]
end
