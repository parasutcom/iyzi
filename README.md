# Iyzi

Iyzico ruby client

Checkout api documentations
https://www.iyzico.com/entegrasyon/ozel-yazilim-entegrasyonu/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iyzi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iyzi

## Setup

Before using the library, you must supply your Iyzico API key and secret. There are two ways to configure. You can either put the code below into initializer:
```ruby
Iyzi.configure do |config|
  config.api_key  = 'API_KEY'
  config.secret   = 'SECRET'
  config.base_url = 'BASE_API_URL' # default 'https://api.iyzipay.com/' if not specified
end
```
or you could send configuration object as a parameter
```ruby
config = Iyzi::Configuration.new(api_key: 'API_KEY', secret: 'SECRET')
params = { bin_number: '411111', config: config }
Iyzi.bin_control(params)
```

## Usage

Checkout [examples](examples.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

