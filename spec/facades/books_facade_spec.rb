require 'rails_helper'

RSpec.describe "BooksFacade" do
  before do
    @facade = BooksFacade.new
  end

  it "exists" do
    expect(@facade).to be_a(BooksFacade)
  end

  it "returns BookSearch object happy path" do
    expect(@facade.book_search("denver,co",5)).to be_a(BookSearch)
  end

  it "returns an ErrorBookSearch sad path" do
    expect(@facade.book_search("gorillatown,zz", 5)).to be_a(ErrorBookSearch)
  end
end