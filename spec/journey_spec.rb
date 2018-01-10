require 'journey'

describe Journey do

  let (:entry_station) { double :entry_station}
  let (:exit_station) { double :exit_station}

  describe "#initialize" do

    subject(:journey) {described_class.new(:entry_station)}

    it "should create a new journey with starting station" do
      expect(journey.entry_station).to eq :entry_station
    end
    it "should create a new journey with destination = nil" do
      expect(journey.exit_station).to eq nil
    end
  end

  describe "#finish" do

    it "should return minimum fare if complete journey" do
      journey = Journey.new(entry_station)
      expect(journey.finish(exit_station)).to eq 1.00
    end

    it "should return penalty fare if incomplete journey" do
      journey = Journey.new
      expect(journey.finish(exit_station)).to eq 6.00
    end

  end

end
