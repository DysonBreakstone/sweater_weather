class ErrorBookSearch
  attr_reader :id, :errors
  def initialize(error)
    @id = nil
    @errors = [error]
  end
end