require 'rails_helper'

RSpec.describe ErrorBookSearch do
  describe "instantiation and attributes" do
    before do
      @error = BooksFacade.new.book_search(";asdhfkjasjhdgfk;jhsag", 5)
    end

    it "exists" do
      expect(@error).to be_a(ErrorBookSearch)
    end

    it "has attributes" do
      expect(@error.id).to eq(nil)
      expect(@error.errors).to be_a(Array)
      expect(@error.errors.first).to be_a(String)
    end
  end
end