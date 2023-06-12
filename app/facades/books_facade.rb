class BooksFacade
  def book_search(city, quantity)
    books_result = LibraryService.new.search_books(city, quantity)
    forecast = WeatherService.new.current_weather(city)
    if forecast[:error]
      return ErrorBookSearch.new(forecast[:error][:message])
    else
      return BookSearch.new(city, books_result, forecast)
    end
  end
end