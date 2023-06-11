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
      @service = WeatherService.new
    end
    
    it "current_weather" do
      exp_keys = {
        last_updated: [String],
        temp_f: [Float, Integer],
        feelslike_f: [Float, Integer],
        humidity: [Float, Integer],
        uv: [Float, Integer],
        vis_miles: [Float, Integer]
      }
      json = @service.current_weather("42.3265,-122.8756")

      expect(json).to be_a(Hash)
      exp_keys.each do |key, type|
        expect(type.include?(json[:current][key].class)).to eq(true)
      end
      expect(json[:current][:condition][:text]).to be_a(String)
      expect(json[:current][:condition][:icon]).to be_a(String)
      expect(json[:current][:condition][:icon].reverse[0,3]).to eq("gnp")
    end

    it "daily weather" do
      exp_keys = {
        date: String,
        day: Hash,
        astro: Hash
      }
      json = @service.daily_weather("42.3265,-122.8756")

      expect(json[:forecast][:forecastday].count).to eq(5)

      exp_keys.each do |key, type|
        expect(json[:forecast][:forecastday].first[key]).to be_a(type)
      end
      expect(json[:forecast][:forecastday].first[:astro][:sunrise]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:astro][:sunset]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:day][:maxtemp_f]).to be_a(Float)
      expect(json[:forecast][:forecastday].first[:day][:mintemp_f]).to be_a(Float)
      expect(json[:forecast][:forecastday].first[:day][:condition][:text]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:day][:condition][:icon]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:day][:condition][:icon].reverse[0,3]).to eq("gnp")
    end

    it "hourly weather" do
      exp_keys = {
        time: String,
        temp_f: Float,
        condition: Hash
      }
      json = @service.hourly_weather("42.3265,-122.8756")

      exp_keys.each do |key, type|
        expect(json[:forecast][:forecastday].first[:hour].first[key]).to be_a(type)
      end
      expect(json[:forecast][:forecastday].first[:hour].first[:condition][:text]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:hour].first[:condition][:icon]).to be_a(String)
      expect(json[:forecast][:forecastday].first[:hour].first[:condition][:icon].reverse[0,3]).to eq("gnp")
    end
  end
end