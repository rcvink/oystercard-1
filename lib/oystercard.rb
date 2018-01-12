require_relative 'journeylog'

class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(journey_log = JourneyLog.new, balance = 0)
    @journey_log = journey_log
    @balance = balance
  end

  def top_up(value)
    fail "Cannot top up beyond limit of #{MAX_BALANCE}" if limit_exceeded?(value)
    @balance += value
  end

  def touch_in(entry_station, journey_log = @journey_log)
    raise "Insufficient balance for journey" if insufficient_funds?
    deduct(journey_log.current_journey.fare) if journey_log.current_journey.incomplete?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys.last.fare)
  end

  def journeys
    @journey_log.journeys
  end

  private

  def insufficient_funds?
    @balance <  MINIMUM_FARE
  end

  def limit_exceeded?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct(value)
    @balance -= value
  end
end
