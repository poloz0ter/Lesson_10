require_relative 'train.rb'

class PassengerTrain < Train
  def initialize(number)
    @type = :passenger
    super
  end

  validate :number, :presence
  validate :number, :format, NUMBER
  validate :type, :presence

  def add_wagon(wagon)
    raise 'Неверный тип вагона' if wagon.type != type

    super
  end
end
