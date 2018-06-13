module Acessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history) }
      define_method("#{name}=".to_sym) do |value|
        history_var = instance_variable_get(history)
        history_var ||= []
        instance_variable_set(history, history_var << value)
        instance_variable_set(var_name, value)
      end
    end
  end
  
  def strong_attr_accessor(attr_name, class_name)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=".to_sym) do |value|
      if value.class == class_name
        instance_variable_set(var_name, value)
      else
        raise 'Unsupported type'
      end
    end
  end
end
