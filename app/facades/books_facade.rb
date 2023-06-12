class BooksFacade
  def book_search(city, quantity)
    # require 'pry'; binding.pry
    books_result = LibraryService.new.search_books(city, quantity)
    forecast = WeatherService.new.current_weather(city)
    BookSearch.new(city, books_result, forecast)
  end
end