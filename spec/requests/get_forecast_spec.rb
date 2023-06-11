require 'rails_helper'

RSpec.describe "weather" do
  describe "existence" do
    it "has response and needed attributes" do
      get "/api/v0/forecast?location=cincinatti,oh"
      json = JSON.parse(response.body, symbolize_names: true)
  
      expect(json).to have_key(:data)
      expect(json[:data][:id].nil?).to eq(true)
      expect(json[:data][:type]).to eq("forecast")
    end
  end

  describe "current weather" do
    before do
      @exp_keys = {
        last_updated: String,
        temperature: Float,
        feels_like: Float,
        humidity: Float,
        uvi: Float,
        visibility: Float,
        condition: String,
        icon: String
      }
      get "/api/v0/forecast?location=cincinatti,oh"
      @current = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:current_weather]
    end

    it "has the required keys" do  
      @exp_keys.each do |key, type|
        expect(@current[key]).to be_a(type)
      end
      expect(@current[:icon].reverse[0,3]).to eq("gnp")
    end

    it "ONLY has the required keys" do
      expect((@current.keys & @exp_keys.map{ |key, value| key })).to eq(@current.keys)
    end
  end

  describe "daily weather" do
    before do
      @exp_keys = {
        date: String,
        sunrise: String,
        sunset: String,
        max_temp: Float,
        min_temp: Float,
        condition: String,
        icon: String
      }
      get "/api/v0/forecast?location=cincinatti,oh"
      @daily = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:daily_weather]
    end

    it "has the required keys" do
      @exp_keys.each do |key, type|
        expect(@daily.first[key]).to be_a(type)
      end
      expect(@daily.first[:icon].reverse[0,3]).to eq("gnp")
    end

    it "ONLY has the required keys" do
      expect((@daily.first.keys & @exp_keys.map{ |key, value| key })).to eq(@daily.first.keys)
    end
  end

  describe "hourly_weather" do
    before do
      @exp_keys = {
        time: String,
        temperature: Float,
        conditions: String,
        icon: String
      }
      get "/api/v0/forecast?location=cincinatti,oh"
      @hourly = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:hourly_weather]
    end

    it "has the required keys" do
      @exp_keys.each do |key, type|
        expect(@hourly.first[key]).to be_a(type)
      end
      expect(@hourly.first[:icon].reverse[0,3]).to eq("gnp")
    end

    it "ONLY has the required keys" do
      expect((@hourly.first.keys & @exp_keys.map{ |key, value| key })).to eq(@hourly.first.keys)
    end
  end
end