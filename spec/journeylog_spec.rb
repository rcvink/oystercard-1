require 'journeylog'

describe JourneyLog do
  let (:journey) { double :journey, finish: nil }
  let (:journey_class) { double :journey_class, new: journey }
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }
  subject(:journeylog) { described_class.new(journey_class) }
  #before { allow(journey_class).to receive(:new).and_return(journey) }

  describe '#start' do
    it 'starts a journey' do
      expect(journeylog.start(entry_station)).to eq journey
    end
  end

  describe '#finish' do
    it 'finished a journey' do
      expect(journeylog.finish(exit_station)).to eq nil
    end
  end

  describe '#journeys' do
    it 'logs a journey' do
      expect(journeylog.journeys).to eq []
    end
  end
end
