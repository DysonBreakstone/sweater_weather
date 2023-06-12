class BooksFacade
  def book_search(city, quantity)
    books_result = BookSearchService.new.search_books(city, quantity)
    forecast = WeatherService.new.current_weather(city)
    require 'pry'; binding.pry
    BookSearch.new(books_result, forecast)
  end
end