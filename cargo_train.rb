class CargoTrain < Train
  def initialize(number)
    super
    @type = :cargo
  end

  def add_wagon(wagon)
    raise 'Неверный тип вагона' if wagon.type != type

    super
  end
end
