class WeatherService
  def conn
    @conn ||= Faraday.new(url: "https://api.weatherapi.com/v1/") do |connection|
      connection.headers["Content-Type"] = "application/json"
      connection.headers["Accept"] = "application/json"
      connection.params["key"] = ENV['WEATHER_API_KEY']
    end
  end

  def current_weather(location)
    response = conn.get("current.json") do |request|
      request.params["q"] = "#{location}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def daily_weather(location)
    response = conn.get("forecast.json") do |request|
      request.params["q"] = "34.01158,-118.49227"
      request.params["days"] = "5"
      request.params["tp"] = "24"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def hourly_weather(location)
    response = conn.get("forecast.json") do |request|
      request.params["q"] = location
      request.params["days"] = "1"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end