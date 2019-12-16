defmodule BoggleWeb.Schema do
  use Absinthe.Schema

  object :score do
    field :score, :integer
  end

  def list_scores_for_user(_parent, _args, resolution) do
    {:ok, Boggle.Score.list_scores_for_user(resolution.context.current_user)}
  end

  query do
    @desc "Get scores for user"
    field :scores, list_of(:score) do
      resolve(&list_scores_for_user/3)
    end
  end

  def submit_new_score(_parent, arg, resolution) do
    {:ok, Boggle.Score.new_score_for_user(arg, resolution.context.current_user)}
  end

  mutation do
    @desc "Submit a score"
    field :create_score, type: :score do
      arg(:score, non_null(:integer))
      resolve(&submit_new_score/3)
    end
  end
end
