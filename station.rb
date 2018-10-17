require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation
  
  @@stations = []
  attr_reader :name, :trains
  validate :name, :presence

  def initialize(name)
    @name = name.to_s.chomp.strip
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def take_train(train)
    @trains << train
  end

  def show_trains
    @trains.each { |train| yield(train) }
  end

  def by_type
    cargo = @trains.select { |train| train.is_a? CargoTrain }
    passenger = @trains.select { |train| train.is_a? CargoTrain }
    puts "Грузовых - #{cargo.size} Пассажирских - #{passenger.size}"
  end

  def send_train(train)
    @trains.delete(train)
  end
end
