class Journey

  attr_reader :entry_station, :exit_station

  MIN_JOURNEY_CHARGE = 1.00
  PENALTY_CHARGE = 6.00

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station, @exit_station = entry_station, exit_station
  end

  def fare(exit_station = nil)
    @exit_station = exit_station
    return PENALTY_CHARGE if incomplete?
    MIN_JOURNEY_CHARGE
  end

  private

  def incomplete?
    @entry_station.nil? || @exit_station.nil?
  end

end
