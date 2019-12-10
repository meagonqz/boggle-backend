defmodule Boggle.Repo do
  use Ecto.Repo,
    otp_app: :boggle,
    adapter: Ecto.Adapters.Postgres
end
