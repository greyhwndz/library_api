defmodule LibraryApiWeb.Router do
  use LibraryApiWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", LibraryApiWeb do
    pipe_through :api
  end
end
