class Api::V1::BookSearchController < ApplicationController
  def index
    if (params[:location].class == String && params[:location].length > 0 && params[:quantity].to_i != 0)
      render json: BookSearchSerializer.new(BooksFacade.new.book_search(params[:location], params[:quantity]))
    else 
      render json: {errors: "Must include location and quantity in search parameters"}, status: 400
    end
  end
end