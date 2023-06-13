class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :id, :start_city, :end_city, :travel_time, :weather_at_eta
  set_type :road_trip
end