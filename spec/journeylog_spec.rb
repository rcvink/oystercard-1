require 'journeylog'

describe JourneyLog do
  let (:journey) { double :journey, finish: nil }
  let (:journey_class) { double :journey_class, new: journey }
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }
  subject(:journeylog) { described_class.new(journey_class) }

  describe '#start' do
    it 'closes a journey if one exists' do
      journeylog.start(entry_station)
      expect(journeylog).to receive(:close_journey)
      journeylog.start(entry_station)
    end

    it 'starts a journey if one does not exist' do
      expect(journeylog.start(entry_station)).to eq journey
    end
  end

  describe '#finish' do
    it 'closes a journey' do
      expect(journeylog).to receive(:close_journey)
      journeylog.finish(exit_station)
    end
  end

  describe '#journeys' do
    it 'returns an empty history if no journeys were completed' do
      expect(journeylog.journeys).to eq []
    end

    it 'returns a history containing one journey after completing a journey' do
      journey = journeylog.start(entry_station)
      journeylog.finish(exit_station)
      expect(journeylog.journeys).to include journey
    end
  end

  describe '#'
end
