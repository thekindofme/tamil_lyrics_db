# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tldb,
  ecto_repos: [Tldb.Repo]

# Configures the endpoint
config :tldb, Tldb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xq08+Hzh7WZVnav6kEXPQGbZCdX79jikq7Clc1wqoCR3TrXgtzmDo1PdPWdKZSBp",
  render_errors: [view: Tldb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tldb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
