use Mix.Config

# Configure your database
config :boggle, Boggle.Repo,
  username: "postgres",
  password: "postgres",
  database: "boggle_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :boggle, BoggleWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
