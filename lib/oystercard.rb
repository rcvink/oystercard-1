require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_history

  MAX_BALANCE = 90.00
  MINIMUM_FARE = 1.00

  def initialize(initial_balance = 0.00)
    @balance = initial_balance
    @journey_history = []
  end

  def top_up(value)
    fail "Cannot top up past maximum balance of #{MAX_BALANCE}" if balance_limit_exceeded?(value)
    @balance += value
  end

  def touch_in(entry_station)
    raise "insufficient balance for journey" if insufficient_funds?
    close_journey(@current_journey) if @current_journey
    @current_journey = create_journey(entry_station)
  end

  def touch_out(exit_station, journey = @current_journey)
    journey = create_journey if journey.nil?
    close_journey(exit_station, journey)
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

  def store_journey(journey)
    @journey_history << journey
    @current_journey = nil
  end

  def close_journey(exit_station = nil, journey)
    journey.finish(exit_station)
    deduct(journey.fare)
    store_journey(journey)
  end

  def create_journey(entry_station = nil, journey_class = Journey)
    journey_class.new(entry_station)
  end

end
