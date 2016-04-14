module Iyzi
  class ApiError < StandardError
    def initialize(message)
      super message
    end
  end
end
