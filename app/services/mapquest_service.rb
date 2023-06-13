class MapquestService
  def conn
    @_conn ||= Faraday.new(url: "https://www.mapquestapi.com") do |connection|
      connection.headers["Content-Type"] = "application/json"
      connection.headers["Accept"] = "application/json"
      connection.params["key"] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_geo_response(city)
    conn.get("/geocoding/v1/address?location=#{city}")
  end

  def lat_lon(city)
    response = JSON.parse(get_geo_response(city).body, symbolize_names: true)
    location = response[:results].first[:locations].first[:latLng]
    "#{location[:lat]},#{location[:lng]}"
  end

  def time_to_destination(city_1, city_2)
    time = {}
    response = JSON.parse(conn.get("/directions/v2/route?from=#{city_1}&to=#{city_2}").body, symbolize_names: true)
    if response[:route][:routeError]
      time[:formatted_time] = "Route is impossible or location does not exist."
    else
      time[:real_time] = response[:route][:realTime]
      time[:formatted_time] = response[:route][:formattedTime]
    end
    time
  end
end