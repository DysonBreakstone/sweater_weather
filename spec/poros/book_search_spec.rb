require 'rails_helper'

RSpec.describe BookSearch do
  describe "Creation and attributes" do
    before do 
      books_result = LibraryService.new.search_books("boulder,co", 5)
      forecast = WeatherService.new.current_weather("boulder,co")
      @larry = BookSearch.new("boulder,co", books_result, forecast)
    end

    it "exists" do
      expect(@larry).to be_a(BookSearch)
    end

    it "attributes" do
      expect(@larry.id).to eq(nil)
      expect(@larry.destination).to eq("boulder,co")
      expect(@larry.forecast).to be_a(Hash)
      expect(@larry.forecast[:summary]).to be_a(String)
      expect(@larry.forecast[:temperature]).to be_a(Float)
      expect(@larry.total_books_found).to be_a(Integer)
      expect(@larry.books).to be_a(Array)
      expect(@larry.books.count).to eq(5)
    end
  end
end