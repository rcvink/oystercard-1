class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90.00

  def initialize(initial_balance = 0.00)
    @balance = initial_balance
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if @balance + value > MAX_BALANCE
    @balance += value
  end

end
