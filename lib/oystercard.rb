require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_history

  MAX_BALANCE = 90.00

  def initialize(initial_balance = 0.00)
    @balance = initial_balance
    @journey_history = []
    @current_journey = nil
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if @balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise "insufficient balance for journey" if @balance < Journey::MIN_JOURNEY_CHARGE
    close_journey if !!@current_journey
    create_journey(entry_station)
  end

  def touch_out(exit_station)
    create_journey if @current_journey.nil?
    close_journey(exit_station)
  end

  private

  def deduct(value)
    @balance -= value
  end

  def store_journey(journey)
    @journey_history << journey
  end

  def close_journey(exit_station = nil)
    deduct(@current_journey.fare(exit_station))
    store_journey(@current_journey)
    @current_journey = nil
  end

  def create_journey(entry_station = nil)
    @current_journey = Journey.new(entry_station)
  end

end
