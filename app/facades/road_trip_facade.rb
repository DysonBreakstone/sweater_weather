class RoadTripFacade
  def create_road_trip(origin, destination)
    map_service = MapquestService.new
    road_time = map_service.time_to_destination(origin, destination)
    if road_time[:formatted_time] == "impossible"
      return RoadTrip.new(origin, destination, road_time[:formatted_time], {})
    end
    real_road_time = road_time[:real_time]
    readable_road_time = road_time[:formatted_time]
    weather_service = WeatherService.new
    arrival_time = time_at_destination(destination, real_road_time)
    arrival_date = arrival_time.strftime("%Y-%m-%d")
    arrival_hour = arrival_time.strftime("%H")
    weather_report = weather_service.weather_at_destination(destination, arrival_date, arrival_hour)
    RoadTrip.new(origin, destination, readable_road_time, weather_report)
  end

  def time_at_destination(destination, real_road_time)
    service = WeatherService.new
    destination_time = service.local_time(destination)
    arrival_time = destination_time + real_road_time
  end
end