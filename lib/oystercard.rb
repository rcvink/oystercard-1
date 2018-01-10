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
    close_journey if @current_journey
    create_journey(entry_station)
  end

  def touch_out(exit_station)
    create_journey if @current_journey.nil?
    close_journey(exit_station)
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
  end

  def close_journey(exit_station = nil)
    fare = @current_journey.finish(exit_station)
    deduct(fare)
    store_journey(@current_journey)
    @current_journey = nil
  end

  def create_journey(entry_station = nil)
    @current_journey = Journey.new(entry_station)
  end

end
