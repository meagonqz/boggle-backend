# Boggle Backend

This API currently allows users to log into Boggle and store their scores.
This projects uses Phoenix as a webserver, with Google OAuth for authentication powered by [Guardian](https://github.com/ueberauth/guardian) and graphQL for APIs powered by [Absinthe](https://github.com/absinthe-graphql/absinthe).

# Local development
This project uses [asdf](https://github.com/asdf-vm/asdf) to manage versions which are pinned in [.tool-versions](./.tool-versions).

After installing asdf, install the plugins
```
asdf plugin-add erlang
asdf plugin-add elixir
```
When those have succeeded, run `asdf install` and verify install via `asdf
current`

# Setting up Phoenix

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start postgres on your system, i.e. on linux `sudo /etc/init.d/postgresql start`
  * Create and migrate your database with `mix ecto.setup`
  * If desired, seed your database with `mix run priv/repo/seeds.exs`
  * Install Node.js dependencies with `cd assets && npm install`
  * Set up secrets as env vars for Guardian token encryption and for Google OAuth
    * GUARDIAN_SECRET (can be created using `mix guardian.gen.secret`)

     You must [create a Google App](https://console.developers.google.com/apis/) with OAuth to get these credentials
    * GOOGLE_CLIENT_ID
    * GOOGLE_CLIENT_SECRET
  * Start Phoenix endpoint with `mix phx.server`
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

After authenticating at [`localhost:4000/auth/google`](http://localhost:4000/auth/google)  you can explore the available APIs with graphiql at  [`localhost:4000/api/graphql`](http://localhost:4000/api/graphql)

# Deployment
The app is hosted on Heroku using [heroku-buildpack-phoenix-static](https://github.com/gjaldon/heroku-buildpack-phoenix-static) at https://peaceful-hamlet-86580.herokuapp.com
