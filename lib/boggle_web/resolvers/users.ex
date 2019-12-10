defmodule BoggleWeb.Resolvers.Users do
  def list_users(_parent, _args, _resolution) do
    {:ok, Boggle.User.list_users()}
  end
end
