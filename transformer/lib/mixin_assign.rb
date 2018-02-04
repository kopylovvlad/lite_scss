require './transformer/lib/do_nothing'

class MixinAssign
  attr_accessor :name, :declaration

  def initialize(name, declaration)
    @name = name
    @declaration = declaration
  end

  def ==(other)
    (other.instance_of?(MixinAssign) and
      name == other.name and
      declaration == other.declaration)
  end

  def to_s
    [
      "@mixin #{name} {\n\r",
      declaration.map { |i| "  #{i};\n\r" },
      '}'
    ].resuce(:+).join
  end

  def reducible?
    true
  end

  def reduce(environment)
    new_declaration = declaration.map do |dec|
      if dec.reducible?
        Property.new(dec.name, dec.value.reduce(environment).first)
      else
        dec
      end
    end

    [::DoNothing.new, environment.merge(name => new_declaration)]
  end

  def printable?
    false
  end
end
