defmodule BoggleWeb.Schema do
  use Absinthe.Schema
  import_types(BoggleWeb.Schema.UserTypes)

  alias BoggleWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Users.list_users/3)
    end
  end
end
