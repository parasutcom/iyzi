module CassetteHelper
  def self.extended(base)
    base.around do |spec|
      VCR.insert_cassette(_cassette, record: _record) if defined?(_cassette) && _cassette
      spec.run
      VCR.eject_cassette if defined?(_cassette) && _cassette
    end
  end

  def cassette(cassette_name, record = 'once')
    let(:_cassette) { cassette_name }
    # record options: [:all, :none, :new_episodes, :once]
    let(:_record) { record.to_sym }
  end
end
