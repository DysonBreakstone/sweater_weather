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
      require 'pry'; binding.pry
    end
  end
end