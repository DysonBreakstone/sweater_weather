require 'rails_helper'

RSpec.describe "Mapquest Service", vcr: { record: :new_episodes } do
  describe "calls" do
    before do
      @service = MapquestService.new
    end

    it "makes call" do
      response = @service.get_geo_response("Calais, VT")
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(json[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(json[:results].first[:locations].first[:latLng]).to have_key(:lng)
    end

    it "#lat_lon" do
      expect(@service.lat_lon("Calais, VT")).to eq("44.37552,-72.49481")
    end

    it "#time_to_destination" do
      time = @service.time_to_destination("plainfield,vt", "crested butte,co")
      expect(time).to be_a(Hash)
      expect(time[:real_time]).to be_a(Integer)
      expect((time[:real_time] > 116500) && (time[:real_time] < 117500)).to eq(true)
      expect(time[:formatted_time]).to be_a(String)
      expect(time[:formatted_time][0,2]).to eq("31")
    end

    it "closer destinations" do
      time = @service.time_to_destination("Boulder,co", "Denver,co")
      expect(time).to be_a(Hash)
      expect(time[:real_time]).to be_a(Integer)
      expect((time[:real_time] > 2000) && (time[:real_time] < 2450)).to eq(true)
      expect(time[:formatted_time]).to be_a(String)
      expect(time[:formatted_time][0,4]).to eq("00:3")
    end

    it "not possible" do
      time = @service.time_to_destination("boulder,co", "hong kong, china")
      expect(time[:formatted_time]).to eq("Route is impossible or location does not exist.")
    end
  end
end