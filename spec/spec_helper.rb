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
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.extend CassetteHelper
end
