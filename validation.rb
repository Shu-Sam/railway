module Validation
  def value(param_name)
    instance_variable_get("@#{param_name}".to_sym)
  end
  
  def presence(param_name, *_)
    raise 'Пустое значение' if value(param_name).nil? || value(param_name).to_s.strip.empty?
  end
  
  def format(param_name, format_name)
    raise 'Ошибочный формат' if value(param_name) !~ format_name
  end
  
  def type(param_name, type)
    raise 'Ошибка типа' if value(param_name).class != type
  end
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.instance_variable_set('@validations', [])
  end
  
  module ClassMethods
    def validate(attr_name, type_validation, params = [])
      @validations << { attr: attr_name, type: type_validation, params: params }
    end
  end
  
  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get('@validations')
      validations.each do |validator|
        send validator[:type], validator[:attr], validator[:params]
      end
    end
    
    def valid?
      begin
        validate!
      rescue StandardError
        return false
      end
      true
    end
  end
end
