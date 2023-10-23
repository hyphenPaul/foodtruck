defmodule FoodtruckWeb.LocationPlug do
  @moduledoc """
  A simple plug to fetch the location of a user by IP.

  IP source: https://www.ipify.org/
  Location Source: https://ip-api.com/docs/api:json
  """

  @ipify "https://api.ipify.org"
  @ipapi "http://ip-api.com/json/"

  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    case conn.params do
      %{"calcuserloc" => "true"} -> inject_user_location(conn)
      _ -> conn
    end
  end

  defp inject_user_location(conn) do
    with {:ok, %{body: ip_string}} <- HTTPoison.get(@ipify),
         {:ok, %{body: location_data}} <- HTTPoison.get("#{@ipapi}#{ip_string}"),
         {:ok, %{"lat" => lat, "lon" => lon}} <- Jason.decode(location_data) do
      conn
      |> assign(:user_lat, lat)
      |> assign(:user_long, lon)
    else
      _ -> conn
    end
  end
end
