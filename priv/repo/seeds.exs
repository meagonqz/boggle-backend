# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Boggle.Repo.insert!(%Boggle.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
user =
Boggle.Repo.insert!(%Boggle.User{
  email: "test@test.com",
  first_name: "Test",
  last_name: "Last",
  provider: "Google",
  token: "something",
  is_admin: false
})

Boggle.Repo.insert!(%Boggle.Score{
  score: 100,
  user_id: 1
})

Boggle.Repo.insert!(%Boggle.Score{
  score: 100,
  user_id: user.id
})
