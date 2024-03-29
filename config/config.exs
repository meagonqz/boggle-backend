# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :boggle,
  ecto_repos: [Boggle.Repo]

# Configures the endpoint
config :boggle, BoggleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ry7/+4Mm5an9l2vTI8S5JdwtRdmxmmsVbFHw216AD3Hv2YCvtaHo5qKY0InCEDYT",
  render_errors: [view: BoggleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Boggle.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :boggle, Boggle.Guardian,
  issuer: "boggle",
  secret_key: System.get_env("GUARDIAN_SECRET")

config :boggle, Boggle.Guardian.AuthPipeline,
  module: Boggle.Guardian,
  error_handler: Boggle.Guardian.AuthErrorHandler

# Configure Google OAuth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email"]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID") || "GOOGLE_CLIENT_ID",
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET") || "GOOGLE_CLIENT_SECRET"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
