class Api::V0::RoadTripController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: body[:api_key])
    if user
      road_trip = RoadTripFacade.new.create_road_trip(body[:origin], body[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: {errors: "Invalid API key"}, status: 401
    end
  end
end