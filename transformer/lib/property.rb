class Property
  attr_accessor :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ==(other)
    (other.instance_of?(Property) and
      name == other.name and
      value == other.value)
  end

  def to_s
    "#{name}: #{value}"
  end

  def reducible?
    value.is_a?(Variable)
  end

  def reduce(environment)
    return unless value.reducible?
    [Property.new(name, expression.reduce(environment).first), environment]
  end

  def printable?
    true
  end
end
