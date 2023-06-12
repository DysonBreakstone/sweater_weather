class ErrorSerializer
  include JSONAPI::Serializer
  attributes :id, :errors
  set_type :error
end