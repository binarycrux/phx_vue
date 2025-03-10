defmodule PhxVue.Repo do
  use Ecto.Repo,
    otp_app: :phx_vue,
    adapter: Ecto.Adapters.Postgres
end
