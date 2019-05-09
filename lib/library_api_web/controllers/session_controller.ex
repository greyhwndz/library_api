defmodule LibraryApiWeb.SessionController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.User

  def create(conn, %{"email" => email, "password" => password}) do
    try do
      user = Library.get_user_by_email!(email)

      conn
      |> render("token.json", user)
    rescue
      _e ->
        conn
        |> put_status(:unauthorized)
        |> render(LibraryApiWeb.ErrorView, "401.json-api", %{detail: "Error logging in a user with that email and password"})
    end
  end
end
