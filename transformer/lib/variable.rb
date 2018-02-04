class Variable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    (other.instance_of?(Variable) and
      name == other.name)
  end

  def to_s
    "$#{name}"
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
