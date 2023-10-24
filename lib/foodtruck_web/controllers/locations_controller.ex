defmodule FoodtruckWeb.LocationsController do
  use FoodtruckWeb, :controller

  alias Foodtruck.Context.Locations

  def index(conn, params) do
    opts = location_opts(conn, params)
    render(conn, :index, locations: Locations.get_all(opts))
  end

  @spec location_opts(Plug.Conn.t(), map()) :: map()
  defp location_opts(_, %{"user_lat" => user_lat, "user_long" => user_long} = params) do
    Map.merge(params, %{
      "user_long" => String.to_float(user_long),
      "user_lat" => String.to_float(user_lat)
    })
  end

  defp location_opts(%{assigns: %{user_lat: user_lat, user_long: user_long}}, params) do
    Map.merge(params, %{"user_long" => user_long, "user_lat" => user_lat})
  end

  defp location_opts(_, params), do: params
end
