require 'journey'

describe Journey do
  subject(:journey) {described_class.new("King's Cross")}

  describe "#initialize" do
    it "should create a new journey with starting station" do
      expect(journey.entry_station).to eq "King's Cross"
    end
    it "should create a new journey with destination = nil" do
      expect(journey.exit_station).to eq nil
    end
  end

end
