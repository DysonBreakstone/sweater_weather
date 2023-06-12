require 'rails_helper'

RSpec.describe Api::V0::SessionsController, :type => :controller do
  describe "Sessions Creation" do
    before do
      @user_1 = User.create!(email: "whatever@example.com", password: "pass", password_confirmation: "pass", api_key: SecureRandom.hex(24))
      @json_payload = {
        email: "whatever@example.com",
        password: "pass"
    }.to_json
      request.headers['Content-Type'] = 'application/json'
    end

    it "creates session" do
      expect(session[:user_id]).to eq(nil)
      
      post :create, body: @json_payload
      expect(session[:user_id]).to eq(@user_1.id)
    end

    it "returns json response" do
      post :create, body: @json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:id].to_i).to eq(@user_1.id)
      expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe "Sad Paths" do
    before do 
      @user_1 = User.create!(email: "whatever@example.com", password: "pass", password_confirmation: "pass", api_key: SecureRandom.hex(24))
    end

    it "bad password" do
      json_payload = {
        email: "whatever@example.com",
        password: "paskjshdfs"
      }.to_json
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json[:errors]).to eq("User does not exist or email and password don't match.")
    end

    it "nonexistent user" do
      json_payload = {
        email: "whatever@badexample.com",
        password: "paskjshdfs"
      }.to_json
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(json[:errors]).to eq("User does not exist or email and password don't match.")
    end
  end
end