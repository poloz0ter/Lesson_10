require_relative 'wagon.rb'
require_relative 'validation.rb'

class PassengerWagon < Wagon
  include Validation
  validate :type, :presence
  validate :free_place, :presence
  
  def initialize(number, free_places)
    super(number)
    @type = :passenger
    @free_places = free_places
    @occup_places = 0
  end

  attr_reader :occup_places, :free_places

  def set_place
    raise 'Больше нет свободных мест' if @free_places.zero?

    @free_places -= 1
    @occup_places += 1
  end
end
