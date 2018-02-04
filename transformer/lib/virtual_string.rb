class VirtualString
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def ==(other)
    (other.instance_of?(VirtualString) and
      value == other.value)
  end

  def to_s
    value.to_s
  end

  def reducible?
    false
  end
end
