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
    it "should set in_journey to true" do
      expect(oystercard.touch_in).to eq true
    end

    it "should raise an error if a card with insufficient balance is touched in" do
      oystercard = Oystercard.new(0.99)
      expect{ oystercard.touch_in }.to raise_error "insufficient balance for journey"
    end

  end

  describe "#touch_out" do
    it "should set in_journey to false" do
      expect(oystercard.touch_out).to eq false
    end

    it "should charge card for journey" do
      expect { oystercard.touch_out }.to change { oystercard.balance }.by (-1.00)
    end
  end

    

end
