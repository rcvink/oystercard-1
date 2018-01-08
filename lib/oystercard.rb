class Oystercard

  attr_reader :balance

  def initialize(initial_balance=0)
    @balance = initial_balance
  end

  def top_up(value)
    @balance += value
  end

end
