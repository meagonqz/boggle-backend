defmodule BoggleWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :boggle

  socket "/socket", BoggleWeb.UserSocket,
    websocket: true,
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :boggle,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug CORSPlug

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    secure: Application.get_env(:boggle, :secure),
    http_only: true,
    key: "_boggle_key",
    signing_salt: "s9xYzpFN",
    # This version of Plug doesn't have same_site
    same_site: "None",
    # I didn't see this added to the cookie in Chrome, though the attribute is in the Plug docs
    # Second Secure is redundant but copying the spec from
    # https://web.dev/samesite-cookies-explained/
    extra: "SameSite=None; Secure"

  plug BoggleWeb.Router
end
