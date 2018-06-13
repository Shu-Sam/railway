require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany
 
  attr_reader :number

  NUMBER_FORMAT = /^([а-я]|[a-z]){2}\d{2}$/i

  def initialize(number, args = {})
    @number = number
    validate!
    post_initialize(args)
  end

  def post_initialize(_args)
    nil
  end
  
end
