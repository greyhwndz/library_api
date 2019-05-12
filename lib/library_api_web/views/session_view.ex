defmodule LibraryApiWeb.SessionView do
  use LibraryApiWeb, :view
  #import Joken.Config

  def render("token.json", user) do
    mydata = %{id: user.id, email: user.email, username: user.username}
    jwt = %{data: mydata, sub: user.id}
    jwt = %{data: mydata, sub: user.id}
    |> Joken.generate_and_sign(Joken.Signer.create("HS512", "SOMESECRETVALUE"))

    %{token: jwt.token}
  end
end
