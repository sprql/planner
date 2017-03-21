# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :planner,
  ecto_repos: [Planner.Repo]

# Configures the endpoint
config :planner, Planner.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zbdLUeZtFR3eC5OYzb/i9j9gq231FindnKXLQUhaS556JRNGjpwZ1uPsZ6+DRBcF",
  render_errors: [view: Planner.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Planner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
