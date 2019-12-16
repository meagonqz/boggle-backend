defmodule Boggle.Score do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "scores" do
    field :score, :integer
    belongs_to(:user, Boggle.User)

    timestamps()
  end

  def list_scores_for_user(%Boggle.User{id: id}) do
    from(s in Boggle.Score,
      where:
        s.user_id ==
          ^id
    )
    |> Boggle.Repo.all()
  end

  def new_score_for_user(%{score: score}, %Boggle.User{id: id}) do
    changeset = Boggle.Score.changeset(%Boggle.Score{user_id: id}, %{score: score})

    Boggle.Repo.insert!(changeset)
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
