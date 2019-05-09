defmodule LibraryApiWeb.ErrorView do
  use LibraryApiWeb, :view

  def render("400.json-api", %Ecto.Changeset{} = changeset) do
    JaSerializer.EctoErrorSerializer.format(changeset)
  end

  def render("404.json-api", _assigns) do
    %{title: "Page not found", status: 404}
    |> JaSerializer.ErrorSerializer.format()
  end

  def render("500.json-api", _assigns) do
    %{title: "Internal server error", status: 500}
    |> JaSerializer.ErrorSerializer.format()
  end

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(_template, assigns) do
    #%{errors: %{detail: Phoenix.Controller.status_message_from_template(template) <> "WOW"}}
    render "500.json-api", assigns
  end
end
