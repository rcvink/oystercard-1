require 'journey'

describe Journey do
  let (:entry_station) { double :entry_station}
  let (:exit_station) { double :exit_station}

  subject(:journey) {described_class.new(entry_station)}

  context 'when starting a journey' do
    describe "#initialize" do
      it "should assign an entry station" do
        expect(journey.entry_station).to eq entry_station
      end
    end
  end

  context 'when finishing a journey' do
    describe '#finish' do
      before {journey.finish(exit_station) }

      it 'should assign an exit station' do
        expect(journey.exit_station).to eq exit_station
      end
    end

    describe "#fare" do
      before do
        journey.finish(exit_station)
        allow(entry_station).to receive(:zone).and_return(2)
      end

      it "should return correct fare if crossing no zones" do
        allow(exit_station).to receive(:zone).and_return(2)
        expect(journey.fare).to eq Journey::BASE_FARE
      end

      it "should return correct fare if crossing one zone positively" do
        allow(exit_station).to receive(:zone).and_return(3)
        expect(journey.fare).to eq Journey::BASE_FARE + 1
      end

      it "should return correct fare if crossing one zone negatively" do
        allow(exit_station).to receive(:zone).and_return(1)
        expect(journey.fare).to eq Journey::BASE_FARE + 1
      end

      it "should return penalty fare if incomplete journey" do
        journey = Journey.new
        expect(journey.fare).to eq Journey::PENALTY_CHARGE
      end
  end
  end
end
