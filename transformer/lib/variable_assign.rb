require './transformer/lib/do_nothing'

class VariableAssign
  attr_accessor :name, :expression

  def initialize(name, expression)
    @name = name
    @expression = expression
  end

  def ==(other)
    (other.instance_of?(VariableAssign) and
      name == other.name and
      expression == other.expression)
  end

  def to_s
    "$#{name}: #{expression}"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [::VariableAssign.new(name, expression.reduce(environment).first), environment]
    else
      [::DoNothing.new, environment.merge(name => expression)]
    end
  end

  def printable?
    false
  end
end
