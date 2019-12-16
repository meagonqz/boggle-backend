defmodule Boggle.Guardian.AuthErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type), reason: reason})
    send_resp(conn, 401, body)
  end
end
