module Iyzi
  module Requests
    class ApiTest < Request
      def initialize(options = {})
        super(Endpoints::HTTP_GET, Endpoints::API_TEST, options)
      end
    end
  end
end
