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
config :planner, Planner.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wz+EDcy2ILD8IZhuFIVIvUHHN43SWDy2xpc7Fw9K3SNqFHk0it+V1/ggpg+qR0CH",
  render_errors: [view: Planner.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Planner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
