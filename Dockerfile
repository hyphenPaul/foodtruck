# Use latest elixir as the base image
FROM elixir:latest

# Set the working directory inside the container
WORKDIR /app

# Update the environment and run the application
 CMD bash -lc "mix local.hex --force \
   && mix local.rebar --force \
   && mix deps.get \
   && mix setup \
   && mix ecto.create \
   && mix ecto.migrate \
   && elixir --sname foodtruck --cookie foodtruck_D3V_oreos -S mix phx.server"
