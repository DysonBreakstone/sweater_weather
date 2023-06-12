class Api::V1::BookSearchController < ApplicationController
  def index
    render json: BookSearchSerializer.new(BooksFacade.new.book_search(params[:location], params[:quantity]))
  end
end