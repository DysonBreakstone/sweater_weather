require 'rails_helper'

RSpec.describe RoadTripFacade, vcr: { record: :new_episodes } do
  describe "methods" do
    it "#time_at_destination" do
      facade = RoadTripFacade.new
      destination_time = WeatherService.new.local_time("denver,co")
      time_to_destination = MapquestService.new.time_to_destination("boulder,co","burlington,vt")[:real_time]
      result = facade.time_at_destination("burlington,vt", time_to_destination)
      total_time = result - (destination_time + time_to_destination)
      expect((total_time > 7100) && (total_time < 7300)).to eq(true)
    end

    it "#create_road_trip" do
      road_trip = RoadTripFacade.new.create_road_trip("boulder,co","burlington,vt")
      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.travel_time).to_not eq("Route is impossible or location does not exist.")
      expect(road_trip.weather_at_eta.empty?).to eq(false)
    end

    it "impossible destination" do
      road_trip = RoadTripFacade.new.create_road_trip("boulder,co", "barcelona,spain")
      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.travel_time).to eq("Route is impossible or location does not exist.")
      expect(road_trip.weather_at_eta.empty?).to eq(true)
    end
  end
end