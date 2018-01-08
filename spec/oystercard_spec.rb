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
      initial_balance = oystercard.balance
      expect(oystercard.top_up(3.50)).to eq (initial_balance + 3.50)
    end

    it "should not allow top-up over max balance" do
      oystercard = Oystercard.new(Oystercard::MAX_BALANCE)
      expect { oystercard.top_up(1.00) }.to raise_error("Cannot top up past maximum balance of #{Oystercard::MAX_BALANCE}")
    end

  end

  describe "#deduct" do

    it "should deduct value from the balance" do
      initial_balance = oystercard.balance
      expect(oystercard.deduct(1.50)).to eq (initial_balance - 1.50)
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
  end

  it "should be in journey after touching in" do
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

end
