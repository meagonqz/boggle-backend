defmodule Boggle.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Boggle.{User, Score}

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string
    field :is_admin, :boolean
    has_many :scores, Score
    timestamps()
  end

  def list_users() do
    Boggle.Repo.all(User)
  end

  @doc false
  def changeset(%User{} = user, params, _is_admin_or_new = true) do
    user
    |> cast(params, [:first_name, :last_name, :email, :provider, :token, :is_admin])
    |> validate_required([:first_name, :last_name, :email, :provider, :token, :is_admin])
    |> unique_constraint(:email)
  end

  def changeset(%User{} = user, params, _is_admin_or_new = false) do
    user
    |> cast(params, [:first_name, :last_name])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :provider,
      :token,
      :is_admin
    ])
    |> unique_constraint(:email)
  end
end
