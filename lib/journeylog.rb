require_relative 'journey'

class JourneyLog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    #create a new journey
    close_journey if @current_journey
    @current_journey = create_journey(station)
  end

  def finish(station)
    #adds exit station to current journey
    close_journey(station)
    #@history
  end

  def journeys
    #returns array of journeys
    @history
  end

  private

  def current_journey
    #return incomplete journey
    #or create a new journey
    @current_journey ||= create_journey
  end

  def store_journey(journey)
    @history << journey
  end

  def create_journey(entry_station = nil)
    @journey_class.new(entry_station)
  end

  def close_journey(exit_station = nil)
    current_journey.finish(exit_station)
    store_journey(@current_journey)
    clear_journey
  end

  def clear_journey
    @current_journey = nil
  end
end
