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
    require 'pry'; binding.pry
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

  def weather_at_destination(location, date, hour)
    response = conn.get("forecast.json") do |request|
      request.params["q"] = location
      request.params["days"] = 1
      request.params["date"] = date
      request.params["hour"] = hour
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def local_time(location)
    response = conn.get("current.json") do |request|
      request.params["q"] = "#{location}"
    end
    result = JSON.parse(response.body, symbolize_names: true)
    DateTime.strptime(result[:location][:localtime], "%Y-%m-%d %H:%M").to_time
  end
end