class BookSearchSerializer
  include JSONAPI::Serializer
  attributes :id, :destination, :forecast, :total_books_found, :books
  set_type :books
end