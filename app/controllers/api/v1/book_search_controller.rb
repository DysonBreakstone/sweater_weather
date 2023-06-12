class Api::V1::BookSearchController < ApplicationController
  def index
    if params[:location] && params[:quantity]
      render json: BookSearchSerializer.new(BooksFacade.new.book_search(params[:location], params[:quantity]))
    else 
      render json: {errors: "Must include location and quantity in search parameters"}
    end
  end
end