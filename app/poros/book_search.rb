class BookSearch
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(books_result, weather_result)
    require 'pry'; binding.pry
  end
end