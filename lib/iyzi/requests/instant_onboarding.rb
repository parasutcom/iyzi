module Iyzi
  module Requests
    class InstantOnboarding < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::INSTANT_ONBOARDING_CREATE, options)
      end
    end
  end
end
