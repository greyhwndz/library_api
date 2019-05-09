defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view

  def render("token.json", user) do
    data = %{id: user.id, email: user.email, username: user.username}

    jwt = %{data: data, sub: user.id}
    |> Joken.token
    |> Joken.with_signer(Joken.hs512("SOMESECRETVALUE"))
    |> Joken.sign
    IO.inspect jwt

    %{token: jwt.token}
  end
end
