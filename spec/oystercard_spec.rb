require "oystercard"

describe Oystercard do
  INITIAL_BALANCE = 5
  let (:entry_station) { double :entry_station}
  let (:exit_station) { double :exit_station}
  let (:journey) { double :journey, fare: 1}
  let (:journey_log) { double :journey_log, start: journey, finish: nil, journeys: [journey] }
  subject(:oystercard) { described_class.new(journey_log, INITIAL_BALANCE) }

  describe '#initialize' do
    it "should initialize with a balance if one is provided" do
      expect(oystercard.balance).to eq INITIAL_BALANCE
    end

    it "should initialize with empty balance if none is provided" do
      oystercard = Oystercard.new(journey_log)
      expect(oystercard.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "should not allow top up beyond maximum balance" do
      expect { oystercard.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error("Cannot top up beyond limit of #{Oystercard::MAX_BALANCE}")
    end

    it "should increase balance" do
      expect{ oystercard.top_up(3) }.to change { oystercard.balance }.by 3
    end
  end

  describe "#touch_in" do
    it "should fail if balance is insufficient to complete any journey" do
      oystercard = Oystercard.new
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance for journey"
    end

    it "should return a new journey" do
      expect(oystercard.touch_in(entry_station)).to eq journey
    end
  end

  describe "#touch_out" do
    it "should reduce balance" do
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }
    end

    it "should return balance" do
      expect(oystercard.touch_out(exit_station)).to eq oystercard.balance
    end
  end

  describe "#journeys" do
    it "should return a list of journeys" do
      expect(oystercard.journeys).to eq [journey]
    end
  end
end
