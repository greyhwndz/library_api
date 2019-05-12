defmodule LibraryApiWeb.SessionController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  #alias LibraryApi.Library.User

  def create(conn, %{"email" => email, "password" => _password}) do
    try do
      user = Library.get_user_by_email!(email)

      conn
      |> put_view(LibraryApiWeb.SessionView)
      |> render("token.json", user)
    rescue
      e ->
        conn
        |> put_status(:unauthorized)
        #|> render(LibraryApiWeb.ErrorView, "401.json-api", %{detail: "Error logging in a user with that email and password"})
        |> put_view(LibraryApiWeb.ErrorView)
        |> render("401.json-api", %{detail: "Error logging in a user with that email and password"})
    end
  end
end
