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


end




end
