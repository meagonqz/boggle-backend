defmodule Boggle.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    has_many :scores, Score
    timestamps()
  end

  def list_users() do
    Boggle.Repo.all(Boggle.User)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
