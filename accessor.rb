module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      varrible = "@#{name}".to_sym
      history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(varrible) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history) }
      define_method("#{name}=".to_sym) do |value|
        history_var = instance_variable_get(history)
        history_var ||= []
        instance_variable_set(history, history_var << value)
        instance_variable_set(varrible, value)
      end
    end
  end
  
  def strong_attr_accessor(attr_name, class_name)
    var = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var) }
    define_method("#{attr_name}=".to_sym) do |value|
      if value.class == class_name
        instance_variable_set(var, value)
      else
        raise 'Unsupported type'
      end
    end
  end
end


class Test
  extend Accessor
  attr_accessor_with_history :my_name, :my_surname
end

# method for test. Delete after check work
def main
  t = Test.new
  t.my_name = "Anton"
  t.my_name = "Anton2"
  t.my_surname = "Sokolov"
  t.my_surname = "Sokolov2"
  print t.my_name_history
  print t.my_surname_history
  t2 = Test.new
  t2.my_name_history
  t2.my_surname_history
  t3 = Test.new
  t3.my_name = "Peter"
  t3.my_surname = "Ivanov"
  puts t3.my_name_history
  puts t3.my_surname_history
end

main