require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  def initialize(from, to)
    @from = from
    @to = to
    validate!
    @stations = [from, to]
    register_instance
  end

  attr_reader :stations, :from, :to
  attr_accessor_with_history :stations, :start_station, :end_station

  validate :from, :presence
  validate :to, :presence
  validate :from, :attr_type, Station
  validate :to, :attr_type, Station

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.values_at(1..-2).include?(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end
