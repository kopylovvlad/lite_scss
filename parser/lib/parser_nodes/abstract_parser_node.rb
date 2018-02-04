require './parser/lib/spliter_regex'

class AbstractParserNode
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ==(other)
    (other.is_a?(AbstractParserNode) &&
      name == other.name &&
      value == other.value)
  end

  def transform
    raise 'does not implement error'
  end

  def selector_start?
    name == 'selector start'
  end

  def selector_end?
    name == 'selector end'
  end

  def mixin_using?
    name == 'mixin using'
  end

  def mixin_start?
    name == 'mixin start'
  end

  def variable_assinment?
    name == 'variable assinment'
  end

  def property?
    name == 'property'
  end

  def property_with_variable?
    name == 'property with variable'
  end

  private

  def property_name
    match_value(SpliterRegex::PROP_NAME)
  end

  def std_gsub(str)
    str.gsub(/^\:/, '').gsub(/\;$/, '').strip
  end

  def match_value(reg_ex)
    value.match(reg_ex).captures[0]
  end
end
