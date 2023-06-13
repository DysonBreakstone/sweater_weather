class Api::V0::RoadTripController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: body[:api_key])
    if user
      RoadTripFacade.create_road_trip(body[:origin], body[:destination])
    else
      render json: {errors: "Invalid API key"}
    end
  end
end