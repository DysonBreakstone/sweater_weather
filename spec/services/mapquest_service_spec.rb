require 'rails_helper'

RSpec.describe "Mapquest Service" do
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
  end
end