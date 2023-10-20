defmodule Foodtruck.Repo do
  use Ecto.Repo,
    otp_app: :foodtruck,
    adapter: Ecto.Adapters.Postgres
end
