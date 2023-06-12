class Api::V1::BookSearchController < ApplicationController
  def index
    if (params[:location].class == String && params[:location].length > 0 && params[:quantity].to_i != 0)
      result = BooksFacade.new.book_search(params[:location], params[:quantity])
      if result.class == BookSearch
        render json: BookSearchSerializer.new(result), status: 200
      else
        render json: ErrorSerializer.new(result), status: 404
      end
    else 
      render json: {errors: "Must include location and quantity in search parameters"}, status: 400
    end
  end
end