defmodule Boggle.GraphQL.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Boggle.{Repo, User}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    {:ok, request_user} =
      conn
      |> Boggle.Guardian.Plug.current_claims()
      |> Boggle.Guardian.resource_from_claims()

    %{current_user: request_user}
  end
end
