require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_history

  MAX_BALANCE = 90.00
  MINIMUM_FARE = 1.00

  def initialize(initial_balance = 0.00, journey_log = JourneyLog.new)
    @balance = initial_balance
    @journey_log = journey_log
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if balance_limit_exceeded?(value)
    @balance += value
  end

  def touch_in(entry_station)
    raise "insufficient balance for journey" if insufficient_funds?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys[-1].fare)
  end

  private

  def insufficient_funds?
    @balance <  MINIMUM_FARE
  end

  def balance_limit_exceeded?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct(value)
    @balance -= value
  end
end
