require_relative 'wagon.rb'
require_relative 'validation.rb'

class CargoWagon < Wagon
  include Validation
  validate :type, :presence
  validate :free_place, :presence
  
  def initialize(number, free_volume)
    super(number)
    @type = :cargo
    @free_volume = free_volume
    @taken_volume = 0
  end

  attr_reader :free_volume, :taken_volume

  def take_volume(vol)
    raise 'Недостаточно места' if vol > @free_volume

    @free_volume -= vol
    @taken_volume += vol
  end
end
