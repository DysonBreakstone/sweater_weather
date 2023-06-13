class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id
  def initialize(origin, destination, road_time, weather_report)
    @id = nil
    @start_city = format_place(origin)
    @end_city = format_place(destination)
    @travel_time = road_time
    @weather_at_eta = format_weather_report(weather_report)
  end

  def format_place(place)
    place = place.split(",")
    place.first.capitalize!
    place.second.upcase!
    place.join(", ")
  end

  def format_weather_report(weather)
    if weather.empty?
      return {}
    end
    {
      datetime: weather[:forecast][:forecastday].first[:hour].first[:time],
      temperature:  weather[:forecast][:forecastday].first[:hour].first[:temp_f].to_f,
      condition: weather[:forecast][:forecastday].first[:hour].first[:condition][:text]
    }
  end
end