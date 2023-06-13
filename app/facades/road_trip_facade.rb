class RoadTripFacade
  def create_road_trip(origin, destination)
    map_service = MapquestService.new
    weather_service = WeatherService.new
    road_time = map_service.time_to_destination(origin, destination)
    real_road_time = road_time[:real_time]
    readable_road_time = road_time[:formatted_time]
    arrival_time = time_at_destination(origin, destination, real_road_time)
    arrival_date = arrival_time.strftime("%Y-%m-%d")
    arrival_hour = arrival_time.strftime("%H")
    weather_report = weather_service.weather_at_destination(destination, arrival_date, arrival_hour)
    RoadTrip.new(origin, destination, readable_road_time, weather_report)
  end

  def time_at_destination(origin, destination, real_road_time)
    service = WeatherService.new
    destination_time = service.local_time(destination)
    origin_time = service.local_time(origin)
    difference = destination_time - origin_time
    arrival_time = origin_time + real_road_time + difference
  end
end