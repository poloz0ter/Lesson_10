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
    rescue
      false
    end

    def validate!
      self.class.check_list.each do |check|
        attr_value = instance_variable_get("@#{check[:attr_name]}")
        send(check[:type], attr_value, check[:option])
      end
    end

    private

    def presence(attr_value, option)
      if attr_value.is_a? String
        raise 'presence error(empty string' if attr_value.empty?
      else
        raise 'presence error(nil)' if attr_value.nil?
      end
    end

    def type(attr_value, option)
      raise 'type error' unless attr_value.is_a?(option)
    end

    def format(attr_value, option)
      raise 'format error' unless attr_value =~ option
    end
  end
end

class Test
  include Validation
  attr_accessor :name, :age, :sex
  validate :name, :presence
  validate :sex, /[abc]/
  validate :age, Integer
end
