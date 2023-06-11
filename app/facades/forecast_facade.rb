class ForecastFacade
  def initialize(city)
    @city = city
  end

  def create_forecast
    service = WeatherService.new
    latlon = MapquestService.new.lat_lon(@city)
    Forecast.new(
      service.current_weather(latlon),
      service.daily_weather(latlon),
      service.hourly_weather(latlon)
    )
  end
end