require 'station'

describe Station do
  subject(:station) {described_class.new("King's Cross", 1)}

  describe "#initialize" do
    it "should create a new station with name" do
      expect(station.name).to eq "King's Cross"
    end
  end

end
