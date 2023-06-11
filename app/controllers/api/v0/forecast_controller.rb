class Api::V0::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(ForecastFacade.new(params[:location]).create_forecast)
  end
end