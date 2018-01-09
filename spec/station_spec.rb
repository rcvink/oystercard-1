require 'station'

describe Station do
  subject(:station) {described_class.new("King's Cross", 1)}

  describe "#initialize" do
    it "should create a new station with name" do
      expect(station.name).to eq "King's Cross"
    end
    it "should create a new station with zone" do
      expect(station.zone).to eq 1
    end
  end

end
