defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view

  def render("token.json", user) do
    %{id: user.id, email: user.email, username: user.username}
  end
end
