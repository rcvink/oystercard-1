require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history

  MAX_BALANCE = 90.00
  MIN_JOURNEY_CHARGE = 1.00

  def initialize(initial_balance = 0.00)
    @balance = initial_balance
    @journey_history = {}
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise "insufficient balance for journey" if @balance < MIN_JOURNEY_CHARGE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_JOURNEY_CHARGE)
    store_journey(@entry_station, exit_station)
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

  def store_journey(entry_station, exit_station)
    self.journey_history.store(entry_station, exit_station)
  end

  def in_journey?
    !@entry_station.nil?
  end
end
