defmodule Boggle.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :boggle

  plug(:fetch_cookies)
  plug(Guardian.Plug.VerifyHttpOnlyCookie, claims: @claims)
  plug Guardian.Plug.EnsureAuthenticated, handler: Boggle.AuthController
  plug Guardian.Plug.LoadResource, allow_blank: true

  # plug(:fetch_cookies)
  # plug(Guardian.Plug.VerifyHttpOnlyCookie, claims: @claims)
  # plug(Guardian.Plug.EnsureAuthenticated,
  # plug(Guardian.Plug.LoadResource, allow_blank: true)
end
