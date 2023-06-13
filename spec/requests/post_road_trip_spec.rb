require 'rails_helper'

RSpec.describe Api::V0::RoadTripController, type: :controller do
  describe "create road trip" do
    before do
      api_key = SecureRandom.hex(24)
      @user_1 = User.create!(email: "whatever@example.com", password: "pass", password_confirmation: "pass", api_key: api_key)
      json_payload = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": api_key
      }
      post :create, body: json_payload
    end

    it "creates road trip object" do

    end
  end
end