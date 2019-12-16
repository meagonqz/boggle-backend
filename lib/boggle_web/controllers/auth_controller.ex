defmodule Boggle.AuthController do
  use BoggleWeb, :controller

  plug Ueberauth

  alias Boggle.User
  alias Boggle.Repo

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google",
      is_admin: false
    }

    changeset = User.changeset(%User{}, user_params, true)

    create(conn, changeset)
  end

  def create(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> create_and_return_token(user)

      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render(Boggle.ErrorView, "401.json")
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end

  defp create_and_return_token(conn, user) do
    {:ok, token, _claims} = Boggle.Guardian.encode_and_sign(user)

    conn
    # secure in prod
    |> put_resp_cookie("guardian_default_token", token)
    |> redirect(
      external:
        Application.get_env(
          :boggle,
          :origin,
          "https://mh-boggle-frontend.herokuapp.com"
        )
    )
  end
end
