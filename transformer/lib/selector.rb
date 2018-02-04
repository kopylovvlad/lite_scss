require './transformer/lib/selector_reducer'

class Selector
  attr_accessor :name, :declaration

  def initialize(name, declaration)
    @name = name
    @declaration = declaration
  end

  def to_s
    [
      ["#{name} {\n\r"],
      declaration.map { |i| "  #{i};\n\r" },
      ['}']
    ].reduce(:+).join
  end

  def ==(other)
    (other.instance_of?(Selector) and
      name == other.name and
      declaration == other.declaration)
  end

  def reducible?
    declaration.map(&:reducible?).include?(true)
  end

  def reduce(environment)
    ::SelectorReducer.new(self).perform(environment)
  end

  def printable?
    true
  end
end
