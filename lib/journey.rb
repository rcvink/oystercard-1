class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_CHARGE = 6.00

  def initialize(entry_station = nil)
    @entry_station= entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    fare
  end

  private

  def fare
    return PENALTY_CHARGE if incomplete?
    1.00
  end

  def incomplete?
    @entry_station.nil? || @exit_station.nil?
  end

end
