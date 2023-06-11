class MapquestService
  def conn
    @_conn ||= Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address") do |connection|
      connection.headers["Content-Type"] = "application/json"
      connection.headers["Accept"] = "application/json"
      connection.params["key"] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_geo_response(city)
    conn.get("?location=#{city}")
  end

  def lat_lon(city)
    response = JSON.parse(get_geo_response(city).body, symbolize_names: true)
    location = response[:results].first[:locations].first[:latLng]
    "#{location[:lat]},#{location[:lng]}"
  end
end