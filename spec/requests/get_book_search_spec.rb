require 'rails_helper'

RSpec.describe "Book Search" do
  describe "get request" do
    before do
      get "/api/v1/book-search", params: {
        location: "burlington,vt",
        quantity: "5"
      }
    end

    it "gets response" do
      expect(response.status).to eq(200)
    end

    it "has expected structure" do
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:data)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data][:type]).to eq("books")
      expect(result[:data][:attributes][:destination]).to eq("burlington,vt")
      expect(result[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(result[:data][:attributes][:forecast][:temperature]).to be_a(Float)
      expect(result[:data][:attributes][:total_books_found]).to be_a(Integer)
      expect(result[:data][:attributes][:books]).to be_a(Array)
      expect(result[:data][:attributes][:books].count).to eq(5)
      expect(result[:data][:attributes][:books].first[:isbn]).to be_a(Array)
      expect(result[:data][:attributes][:books].first[:title]).to be_a(String)
      expect(result[:data][:attributes][:books].first[:publisher]).to be_a(Array)
    end

    it "ONLY has the required keys and attributes" do
      result = JSON.parse(response.body, symbolize_names: true)
      exp_keys = [:id, :type, :attributes]
      exp_attributes = [:destination, :forecast, :total_books_found, :books, :id]
      expect((result[:data].keys & exp_keys).sort).to eq(result[:data].keys.sort)
      expect((result[:data][:attributes].keys & exp_attributes).sort).to eq(result[:data][:attributes].keys.sort)
    end
  end

  describe "Sad Path" do
    it "no location" do
      get "/api/v1/book-search", params: {
        location: "",
        quantity: "5"
      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(json[:errors]).to eq("Must include location and quantity in search parameters")
    end

    it "no quantity" do
      get "/api/v1/book-search", params: {
        location: "columbus,oh",
        quantity: ""
      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(json[:errors]).to eq("Must include location and quantity in search parameters")
    end

    it "nonexistent city" do
      get "/api/v1/book-search", params: {
        location: "gorrillatown,zz",
        quantity: "5"
      }
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(404)
      expect(json[:data][:type]).to eq("error")
      expect(json[:data][:attributes][:errors].first).to eq("No matching location found.")
    end
  end
end