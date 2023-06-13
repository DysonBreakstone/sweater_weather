require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe "methods" do
    it "#time_at_destination" do
      facade = RoadTripFacade.new
      destination_time = WeatherService.new.local_time("denver,co")
      time_to_destination = MapquestService.new.time_to_destination("boulder,co","burlington,vt")[:real_time]
      result = facade.time_at_destination("boulder,co", "burlington,vt", time_to_destination)
      total_time = result - (destination_time + time_to_destination)
      expect((total_time > 7100) && (total_time < 7300)).to eq(true)
    end

    it "#create_road_trip" do
      road_trip = RoadTripFacade.new.create_road_trip("boulder,co","burlington,vt")
      require 'pry'; binding.pry
    end
  end
end