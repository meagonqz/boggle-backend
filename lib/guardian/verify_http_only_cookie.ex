if Code.ensure_loaded?(Plug) do
  defmodule Guardian.Plug.VerifyHttpOnlyCookie do
    require Logger

    @moduledoc """
    Looks for and validates a token found in the request cookies.
    In the case where:
    a. The cookies are not loaded
    b. A token is already found for `:key`
    This plug will not do anything.
    This, like all other Guardian plugs, requires a Guardian pipeline to be setup.
    It requires an implementation module, an error handler and a key.
    These can be set either:
    1. Upstream on the connection with `plug Guardian.Pipeline`
    2. Upstream on the connection with `Guardian.Pipeline.{put_module, put_error_handler, put_key}`
    3. Inline with an option of `:module`, `:error_handler`, `:key`
    If a token is found but is invalid, the error handler will be called with
    `auth_error(conn, {:invalid_token, reason}, opts)`
    Once a token has been found it will be added to the conn.
    They will be available using `Guardian.Plug.current_token/2`
    This plugin is implemented with tokens from cookies to be of type `access`
    Options:
    * `:key` - The location of the token (default `:default`, guardian_default_token)
    """

    import Plug.Conn
    import Guardian.Plug.Keys

    alias Guardian.Plug, as: GPlug
    alias GPlug.Pipeline

    def init(opts), do: opts

    @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
    def call(%{req_cookies: %Plug.Conn.Unfetched{}} = conn, _opts), do: conn

    def call(conn, opts) do
      with nil <- GPlug.current_token(conn, opts),
           {:ok, token} <- find_token_from_cookies(conn, opts),
           module <- Pipeline.fetch_module!(conn, opts),
           claims_to_check <- Keyword.get(opts, :claims, %{}),
           key <- storage_key(conn, opts),
           {:ok, claims} <-
             Guardian.decode_and_verify(module, token, claims_to_check, opts) do
        conn
        |> GPlug.put_current_token(token, key: key)
        |> GPlug.put_current_claims(claims, key: key)
      else
        :no_token_found ->
          Logger.debug(inspect(opts))
          Logger.debug("No token found")
          conn

        {:error, reason} ->
          conn
          |> Pipeline.fetch_error_handler!(opts)
          |> apply(:auth_error, [conn, {:invalid_token, reason}, opts])
          |> halt()

        _ ->
          conn
      end
    end

    defp find_token_from_cookies(conn, opts) do
      key = conn |> storage_key(opts) |> token_key()
      token = conn.req_cookies[key] || conn.req_cookies[to_string(key)]
      if token, do: {:ok, token}, else: :no_token_found
    end

    defp storage_key(conn, opts), do: Pipeline.fetch_key(conn, opts)
  end
end
