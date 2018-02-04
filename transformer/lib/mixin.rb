class Mixin
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    (other.instance_of?(Mixin) and name == other.name)
  end

  def to_s
    "@#{name}"
  end

  def reducible?
    true
  end

  def reduce(environment)
    [environment[name], environment]
  end

  def printable?
    true
  end
end
