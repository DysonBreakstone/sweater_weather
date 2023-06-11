require 'rails_helper'

RSpec.describe "calls" do
  describe "connection" do
    before do 
      @service = WeatherService.new
    end
    it "establishes connection" do
      response = @service.conn.get("current.json?q=34.01158,-118.49227")

      expect(response.status).to eq(200)
    end
  end

  describe "acquisitions" do
    before do
      @exp_keys = {
        last_updated: [String],
        temp_f: [Float, Integer],
        feelslike_f: [Float, Integer],
        humidity: [Float, Integer],
        uv: [Float, Integer],
        vis_miles: [Float, Integer]
    }
      @service = WeatherService.new
    end

    it "current_weather" do
      json = @service.current_weather("42.3265,-122.8756")

      expect(json).to be_a(Hash)
      @exp_keys.each do |key, type|
        expect(type.include?(json[:current][key].class)).to eq(true)
      end
      expect(json[:current][:condition][:text]).to be_a(String)
      expect(json[:current][:condition][:icon]).to be_a(String)
      expect(json[:current][:condition][:icon].reverse[0,3]).to eq("gnp")
    end
  end
end