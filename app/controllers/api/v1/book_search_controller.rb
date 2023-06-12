class Api::V1::BookSearchController < ApplicationController
  def index
    render json: BookSerializer.new(BooksFacade.new.book_search(params[:city], params[:quantity]))
  end
end