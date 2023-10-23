defmodule FoodtruckWeb.LocationsController do
  use FoodtruckWeb, :controller

  alias Foodtruck.Context.Locations

  def index(conn, params) do
    render(conn, :index, locations: Locations.get_all(params))
  end
end
