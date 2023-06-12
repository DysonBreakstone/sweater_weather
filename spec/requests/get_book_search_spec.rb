require 'rails_helper'

RSpec.describe "Book Search" do
  describe "get request" do
    before do
      @response = get "/api/v1/book-search", params: {
        location: "denver,co",
        quantity: "5"
      }
    end

    it "gets response" do
      require 'pry'; binding.pry
      expect(@response.status).to eq(200)
    end

    it "has expected structure" do
      result = JSON.parse(@response.body, symbolize_names: true)
      expect(result).to have_key(:data)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data][:type]).to eq("books")
      expect(result[:data][:attributes][:destination]).to eq("denver,co")
      expect(result[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(result[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(result[:data][:attributes][:total_books_found]).to be_a(Integer)
      expect(result[:data][:attributes][:books]).to be_a(Array)
      expect(result[:data][:attributes][:books].count).to eq(5)
      expect(result[:data][:attributes][:books].first[:isbn]).to be_a(Array)
      expect(result[:data][:attributes][:books].first[:title]).to be_a(String)
      expect(result[:data][:attributes][:books].first[:publisher]).to be_a(Array)
    end
  end
end