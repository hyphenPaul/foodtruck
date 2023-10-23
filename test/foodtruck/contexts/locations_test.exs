defmodule Foodtruck.Contexts.LocationsTest do
  use Foodtruck.DataCase

  alias Foodtruck.Context.Locations
  alias Foodtruck.Location

  describe "get_all/1" do
    setup do
      l1 = insert!(:location, locationid: "1", address: "foo")
      l2 = insert!(:location, locationid: "2", address: "foo")
      l3 = insert!(:location, locationid: "3", address: "bar")

      {:ok, %{locations: [l1, l2, l3]}}
    end

    test "get all locations", %{locations: locations} do
      assert results = Locations.get_all(%{})
      assert Enum.count(results) == Enum.count(locations)
    end

    test "filters by values", %{locations: [l1, l2, l3]} do
      assert results = Locations.get_all(%{"locationid" => "1"})
      assert results == [l1]

      assert results = Locations.get_all(%{"address" => "foo"})
      assert Enum.sort_by(results, & &1.locationid) == Enum.sort_by([l1, l2], & &1.locationid)

      assert results = Locations.get_all(%{"address" => "bar"})
      assert results == [l3]
    end
  end

  describe "get/1" do
    setup do
      l1 = insert!(:location, locationid: "123", address: "foo")
      l2 = insert!(:location, locationid: "456", address: "bar")

      {:ok, %{locations: [l1, l2]}}
    end

    test "gets a location", %{locations: [_l1, l2]} do
      assert %Location{} = result = Locations.get(%{"id" => l2.locationid})
      assert result.address == l2.address
    end
  end

  describe "create/1" do
    test "creates a location" do
      assert {:ok, result} = Locations.create(%{"locationid" => "123", "address" => "foo"})
      assert location = Foodtruck.Repo.one(Location)
      assert result.locationid == location.locationid
    end

    test "creates with lat long as strings" do
      assert {:ok, result} = Locations.create(%{"latitude" => Decimal.new("123.456"), "longitude" => Decimal.new("456.789")})
    end
  end
end
