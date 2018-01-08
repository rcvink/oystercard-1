require "oystercard"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it "should return balance" do
    expect(subject.balance).to eq 0
  end



end
