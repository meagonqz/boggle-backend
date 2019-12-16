defmodule Boggle.Guardian do
  use Guardian, otp_app: :boggle

  alias Boggle.User
  alias Boggle.Repo

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, "User:#{id}"}
  end

  def subject_for_token(_, _) do
    {:error, "Unknown resource type"}
  end

  def resource_from_claims(claims) do
    find_resource(claims["sub"])
  end

  def find_resource("User:" <> id) do
    {:ok, Repo.get(User, id)}
  end

  def find_resource(_) do
    {:error, "Unknown resource type"}
  end
end
