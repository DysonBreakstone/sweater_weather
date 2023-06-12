require 'rails_helper'

RSpec.describe Api::V0::UsersController, :type => :controller do
  describe "Happy Path" do
    before do
      json_payload = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }.to_json
    
      request.headers['Content-Type'] = 'application/json'
      @response = post :create, body: json_payload
    end

    it "gets response" do
      expect(@response.status).to eq(201)
    end

    it "has body with email and api_key" do
      json = JSON.parse(@response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:id].to_i).to be_a(Integer)
      expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe "Sad Path" do
    it "taken email" do
      json_payload = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }.to_json
    
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      response = post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json.first).to eq("Email has already been taken")
    end

    it "non-matching passwords" do
      json_payload = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password1"
      }.to_json
    
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      response = post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json.first).to eq("Password confirmation doesn't match Password")
    end

    it "missing email" do
      json_payload = {
        "email": "",
        "password": "password",
        "password_confirmation": "password"
      }.to_json
    
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      response = post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json.first).to eq("Email can't be blank")
    end

    it "missing password" do
      json_payload = {
        "email": "whatever@example.com",
        "password": "",
      }.to_json
    
      request.headers['Content-Type'] = 'application/json'
      post :create, body: json_payload
      response = post :create, body: json_payload
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json.first).to eq("Password can't be blank")
    end
  end
end