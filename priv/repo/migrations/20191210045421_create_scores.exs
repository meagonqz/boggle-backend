defmodule Boggle.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :score, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:scores, [:user_id])
  end
end
