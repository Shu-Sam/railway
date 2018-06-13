require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_accessor :trains
  attr_reader :name

  @@stations = []

  validate :name, :presence
  validate :name, :type, String
  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def arrival_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def to_s
    name
  end

  def each_train
    trains.each { |train| yield train }
  end
  
end
