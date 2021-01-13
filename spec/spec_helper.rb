require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'iyzi'

require 'webmock/rspec'
require 'vcr'
require 'ap'

RSPEC_ROOT = File.dirname(__FILE__)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{RSPEC_ROOT}/support/**/*.rb"].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = "#{RSPEC_ROOT}/fixtures/vcr_cassettes"
  c.default_cassette_options = { match_requests_on: [:method, :uri, :body, :query, :body_as_json] }
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = false
  c.ignore_hosts 'codeclimate.com'
end

RSpec.configure do |config|
  config.include BaseHelper
  config.extend CassetteHelper
end
