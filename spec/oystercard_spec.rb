require "oystercard"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe "#balance" do

    it "should return balance" do
      expect(oystercard.balance).to eq 0
    end

  end

  describe "#top_up" do

    it "should increase balance" do
      expect(oystercard.top_up(3.50)).to eq 3.50
    end

    it "should not allow top-up over max balance" do
      oystercard = Oystercard.new(Oystercard::MAX_BALANCE)
      expect { oystercard.top_up(1.00) }.to raise_error("Cannot top up past maximum balance of #{Oystercard::MAX_BALANCE}")
    end

  end

  describe "#deduct" do

    it "should deduct value from the balance" do
      oystercard = Oystercard.new(5.00)
      expect(oystercard.deduct(1.50)).to eq 3.50
    end


  end

end
