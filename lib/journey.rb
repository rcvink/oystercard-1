class Journey

  attr_reader :entry_station, :exit_station

  MIN_JOURNEY_CHARGE = 1.00
  PENALTY_CHARGE = 6.00

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station, @exit_station = entry_station, exit_station
  end

  def fare(exit_station)
    return PENALTY_CHARGE if entry_station.nil? || exit_station.nil?
    MIN_JOURNEY_CHARGE
  end

  # def in_journey?
  #   !@entry_station.nil?
  # end

end
