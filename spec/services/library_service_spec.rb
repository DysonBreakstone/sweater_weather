require 'rails_helper'

RSpec.describe "Library Service" do
  describe "calls" do
    before do
      @service = LibraryService.new
      @params = {
        q: "kahului,hi",
        limit: 5
      }
      @url = "/search.json"
    end

    it "makes call" do
      response = @service.get_url(@url, @params)

      expect(response.status).to eq(200)
    end

    it "gets results" do
      response = @service.get_url(@url, @params)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:numFound]).to be_a(Integer)
      expect(body).to have_key(:docs)
      expect(body[:docs].first[:title]).to be_a(String)
      expect(body[:docs].first[:isbn]).to be_a(Array)
      expect(body[:docs].first[:publisher].first).to be_a(String)
    end
  end
end