module Accessor
  def attr_accessor_with_history(*attr_names)
    attr_names.each do |attr_name|
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[attr_name] ||= []
        @history[attr_name] << value
      end
      define_method("#{attr_name}_history") { @history[attr_name] }
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=") do |value|
      raise 'Wrong class of value' unless value.is_a?(attr_class)

      instance_variable_set(var_name, value)
    end
  end
end
