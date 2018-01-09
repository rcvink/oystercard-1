require_relative 'journey'

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
    touch_out(nil) if !!@current_journey # if incomplete journey exists, complete it with exit_stn = nil (=> max fare)
    @current_journey = Journey.new(entry_station)
    @current_journey.entry_station
  end

  def touch_out(exit_station)
    touch_in(nil) if @current_journey.nil? # if no existing journey, create one w/ entry_stn =  nil (=> max fare)
    deduct(@current_journey.fare(exit_station))
    store_journey(@current_journey)
    @current_journey = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

  def store_journey(journey)
    @journey_history << journey
  end


end
