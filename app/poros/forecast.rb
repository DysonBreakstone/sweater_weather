class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(current, daily, hourly)
    @current_weather = current_hash(current)
    @daily_weather = daily_hash(daily)
    @hourly_weather = hourly_hash(hourly)
  end

  def current_hash(current)
    {
      last_updated: current[:current][:last_updated],
      temperature: current[:current][:temp_f].to_f,
      feels_like: current[:current][:feelslike_f].to_f,
      humidity: current[:current][:humidity].to_f,
      uvi: current[:current][:uv].to_f,
      visibility: current[:current][:vis_miles].to_f,
      condition: current[:current][:condition][:text],
      icon: current[:current][:condition][:icon]
    }
  end

  def daily_hash(daily)
    days = []
    daily[:forecast][:forecastday].each do |day|
      days << {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f].to_f,
        min_temp: day[:day][:mintemp_f].to_f,
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
    days
  end

  def hourly_hash(hourly)
    hours = []
    hourly[:forecast][:forecastday].first[:hour].each do |hour|
      hours << {
        time: hour[:time].reverse[0,5].reverse,
        temperature: hour[:temp_f].to_f,
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
    hours
  end
end