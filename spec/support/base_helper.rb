module BaseHelper
  def stub_random_string(str = 'random_string')
    allow_any_instance_of(Iyzi::Request).to receive(:random_string).and_return(str)
  end
end