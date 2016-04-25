module BaseHelper
  def stub_random_string(str = 'random_string')
    allow_any_instance_of(Iyzi::Request).to receive(:random_string).and_return(str)
  end

  def stub_config(api_key = 'IYZICO_API_KEY', secret = 'secret')
    allow(Iyzi).to receive(:configuration)
      .and_return(Iyzi::Configuration.new(api_key: api_key, secret: secret))
  end
end