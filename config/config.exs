# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :library_api,
  ecto_repos: [LibraryApi.Repo]

# Configures the endpoint
config :library_api, LibraryApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y7rQ5CDcaRS6w63uwgnu7Ih7snoHRu56PyU2AANRXGwvWoeXz8oYneIqgtQy/vAT",
  render_errors: [view: LibraryApiWeb.ErrorView, accepts: ~w(json json-api)],
  pubsub: [name: LibraryApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure JaSerializer
config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}
#config :phoenix, :format_encoders, "json-api": Poison
config :phoenix, :format_encoders, "json-api": Jason
#config :ja_serializer,
#  page_base_url: "http://localhost:4000/api/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
