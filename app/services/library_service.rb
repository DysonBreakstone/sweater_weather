class LibraryService
  def conn
    @_conn ||= Faraday.new(url: "https://openlibrary.org")
  end

  def get_url(url, params)
    # require 'pry'; binding.pry
    conn.get(url, params)
  end

  def search_books(city, quantity)
    params = {
      q: city,
      quantity: quantity
    }
    response = get_url("/search.json", params)
    JSON.parse(response.body, symbolize_names: true)
  end
end