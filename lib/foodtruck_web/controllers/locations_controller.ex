defmodule FoodtruckWeb.LocationsController do
  use FoodtruckWeb, :controller

  alias Foodtruck.Context.Locations

  def index(conn, params) do
    opts =
      case conn.assigns do
        %{user_lat: user_lat, user_long: user_long} ->
          Map.merge(params, %{"user_long" => user_long, "user_lat" => user_lat})

        _ ->
          params
      end

    render(conn, :index, locations: Locations.get_all(opts))
  end
end
