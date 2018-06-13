require_relative 'train'
require_relative 'validation'

class CargoTrain < Train
  include InstanceCounter
  include Validation

  validate :train_number, :presence
  validate :train_number, :type, String
  validate :train_number, :format, NUMBER_FORMAT
  
  def attach_wagon(wagon)
    if wagon.is_a?(CargoWagon)
      super(wagon)
    else
      puts 'Тип вагона и тип поезда должны совпадать'
    end
  end

  def kind
    ' - грузовой поезд'
  end
end
