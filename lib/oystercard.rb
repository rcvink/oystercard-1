class Oystercard

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  MAX_BALANCE = 90.00
  MIN_JOURNEY_CHARGE = 1.00

  def initialize(initial_balance = 0.00)
    @balance = initial_balance
    @in_journey = false
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    raise "insufficient balance for journey" if @balance < MIN_JOURNEY_CHARGE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
