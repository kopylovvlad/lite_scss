class SelectorReducer
  attr_accessor :selector, :new_declaration

  def initialize(selector)
    @selector = selector
    @new_declaration = []
  end

  def perform(environment)
    selector.declaration.map do |dec|
      if dec.reducible?
        reduce_declaration(dec, environment)
      else
        new_declaration.push(dec)
      end
    end

    [::Selector.new(selector.name, new_declaration), environment]
  end

  private

  def reduce_declaration(dec, environment)
    if dec.is_a?(Property)
      add_as_property(dec, environment)
    elsif dec.is_a?(Mixin)
      add_as_mixin(dec, environment)
    else
      raise 'undefined declaration'
    end
  end

  def add_as_property(dec, environment)
    new_declaration.push(
      ::Property.new(dec.name, dec.value.reduce(environment).first)
    )
  end

  def add_as_mixin(dec, environment)
    environment[dec.name].each { |i| new_declaration.push(i) }
  end
end
