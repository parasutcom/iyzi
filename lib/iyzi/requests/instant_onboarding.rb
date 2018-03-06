module Iyzi
  module Requests
    class InstantOnboarding < Request
      def initialize(options = {})
        super(Endpoints::HTTP_POST, Endpoints::INSTANT_ONBOARDING_CREATE, prepare(options))
      end

      def prepare(options)
        config = options[:config] || Iyzi.configuration
        fail 'config must be passed' unless config.present?

        random_key         = SecureRandom.urlsafe_base64(6, false)
        hash_str           = [config.api_key, config.secret, random_key].join('|')
        hash_digest_base64 = Digest::SHA512.base64digest(hash_str)

        headers = {
          'x-iyzi-developer-key' => hash_digest_base64,
          'x-iyzi-app-name'      => config.secret,
          'x-iyzi-rnd'           => random_key
        }

        options.merge(headers: headers)
      end
    end
  end
end
