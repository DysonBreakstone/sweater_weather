class BookSearch
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id

  def initialize(city, books_result, weather_result)
    @id = nil
    @destination = city
    @forecast = format_forecast(weather_result)
    @total_books_found = books_result[:numFound]
    @books = format_books(books_result[:docs])
  end

  def format_books(data)
    data.map do |datum|
      {
        isbn: datum[:isbn],
        title: datum[:title],
        publisher: datum[:publisher]
      }
    end
  end

  def format_forecast(data)
    {
      summary: data[:current][:condition][:text],
      temperature: data[:current][:temp_f].to_f
    }
  end
end