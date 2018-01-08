require "oystercard"

describe Oystercard do

  subject(:oystercard) { described_class.new(5.00) }

  describe "#balance" do

    it "should return balance" do
      expect(oystercard.balance).to eq 5.00
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

    let (:entry_station) { double :entry_station}

    it "should raise an error if a card with insufficient balance is touched in" do
      oystercard = Oystercard.new(0.99)
      expect{ oystercard.touch_in(entry_station) }.to raise_error "insufficient balance for journey"
    end

    it "expects the card to remember the entry station after touch in" do
      expect(oystercard.touch_in(entry_station)).to eq entry_station
    end

  end

  describe "#touch_out" do
    it "should set in_journey to false" do
      expect(oystercard.touch_out).to eq nil
    end

    it "should charge card for journey" do
      expect { oystercard.touch_out }.to change { oystercard.balance }.by (-1.00)
    end
  end



end
