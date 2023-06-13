require 'rails_helper'

RSpec.describe RoadTrip, vcr: { record: :new_episodes } do
  describe "creation" do
    before do
      @road_trip = RoadTripFacade.new.create_road_trip("seattle,wa", "tallahassee,fl")\
    end

    it "exists" do
      expect(@road_trip).to be_a(RoadTrip)
    end

    it "has attributes" do
      exp_attr = [:@id, :@start_city, :@end_city, :@travel_time, :@weather_at_eta]
      expect(@road_trip.instance_variables.sort).to eq(exp_attr.sort)
    end
  end
end