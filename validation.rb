module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :check_list

    def validate(attr_name, type, *option)
      @check_list ||= []
      @check_list << { attr_name: attr_name, type: type, option: option }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.check_list.each do |check|
        attr_value = instance_variable_get("@#{check[:attr_name]}")
        method_name = "validate_#{check[:type]}".to_sym
        send(method_name, attr_value, check[:option])
      end
    end

    private

    def validate_presence(attr_value, _option)
      if attr_value.is_a? String
        raise 'presence error(empty string' if attr_value.empty?
      else
        raise 'presence error(nil)' if attr_value.nil?
      end
    end

    def validate_type(attr_value, option)
      raise 'type error' unless attr_value.is_a?(option[0])
    end

    def validate_format(attr_value, option)
      raise 'format error' if attr_value !~ option[0]
    end
  end
end
