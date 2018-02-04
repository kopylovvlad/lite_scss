require './transformer/lib/virtual_string'
require './transformer/lib/variable'

class AstNodeValue
  attr_accessor :class_name, :value

  def initialize(class_name, value)
    @class_name = class_name
    @value = value
  end

  def ==(other)
    (other.instance_of?(AstNodeValue) &&
      class_name == other.class_name &&
      value == other.value)
  end

  def transform_for_machine
    if class_name == 'VirtualString.new'
      ::VirtualString.new(value)
    elsif class_name == 'Variable.new'
      ::Variable.new(value.to_sym)
    else
      raise "undefined class_name: #{class_name}"
    end
  end
end
