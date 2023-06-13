require 'rails_helper'

RSpec.describe Api::V0::RoadTripController, type: :controller, vcr: { record: :new_episodes } do
  describe "create road trip" do
    before do
      api_key = SecureRandom.hex(24)
      @user_1 = User.create!(email: "whatever@example.com", password: "pass", password_confirmation: "pass", api_key: api_key)
      session[:user_id] = @user_1.id
      @json_payload = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": api_key
      }.to_json
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
    end
    
    it "gets response" do
      post :create, body: @json_payload
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(201)
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:attributes][:start_city]).to eq("Cincinatti, OH")
      expect(json[:data][:attributes][:end_city]).to eq("Chicago, IL")
      expect(json[:data][:attributes][:travel_time][0,2]).to eq("04")
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end
  end
end