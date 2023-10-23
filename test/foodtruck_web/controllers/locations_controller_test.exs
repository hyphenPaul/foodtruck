defmodule FoodtruckWeb.LocationsControllerTest do
  use FoodtruckWeb.ConnCase

  describe "index/2" do
    setup do
      insert!(:location, locationid: "1", address: "foo")
      insert!(:location, locationid: "2", address: "foo")
      insert!(:location, locationid: "3", address: "bar")

      :ok
    end

    test "renders locations in json", %{conn: conn} do
      conn = get(conn, ~p"/api/locations")

      assert response = json_response(conn, 200)
      assert Enum.count(response) == 3
    end

    test "filters by values", %{conn: conn} do
      conn = get(conn, ~p"/api/locations", address: "foo")

      assert response = json_response(conn, 200)
      assert Enum.count(response) == 2
    end
  end
end
