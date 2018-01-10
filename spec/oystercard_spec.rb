require "oystercard"

describe Oystercard do

  subject(:oystercard) { described_class.new(5.00) }

  let (:entry_station) { double :entry_station}
  let (:exit_station) { double :exit_station}
  let (:journey) { double :journey}

  describe "#initialize" do

    it "should create blank journey history" do
      expect(oystercard.journey_history).to be_empty
    end

  end

  describe "#top_up" do
    it "should increase balance" do
      expect{ oystercard.top_up(3.50) }.to change { oystercard.balance }.by (3.50)
    end

    it "should not allow top-up over max balance" do
      oystercard = Oystercard.new(Oystercard::MAX_BALANCE)
      expect { oystercard.top_up(1.00) }.to raise_error("Cannot top up past maximum balance of #{Oystercard::MAX_BALANCE}")
    end
  end

  describe "#touch_in" do
    it "should raise an error if a card with insufficient balance is touched in" do
      oystercard = Oystercard.new(0.99)
      expect{ oystercard.touch_in(entry_station) }.to raise_error "insufficient balance for journey"
    end

    it "expects the card to create journey object after touch in" do
      expect(oystercard.touch_in(entry_station)).to be_a Journey
    end
  end

  describe "#touch_out" do

    before { allow(journey).to receive(:finish).and_return(1.00) }

    it "should charge card for journey" do
      expect { oystercard.touch_out(exit_station, journey) }.to change { oystercard.balance }.by (-1.00)
    end

    it "should clear current journey on touch out" do
      expect(oystercard.touch_out(exit_station, journey)).to eq nil
    end

    it "should store a journey after touching out" do
      oystercard.touch_out(exit_station, journey)
      expect(oystercard.journey_history).to include journey
    end
  end

end
