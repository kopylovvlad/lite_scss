require './parser/lib/spliter_regex'
Dir['./parser/lib/parser_nodes/*.rb'].each { |file| require file }

###
# class for build instanse of ParserNode
class ParserNodeBuilder
  attr_reader :string

  NAME_DICTIONARY = [
    [SpliterRegex::SELECTOR_START, 'selector start', SelectorStartParserNode],
    [SpliterRegex::PROPERTY, 'property', PropertyParserNode],
    [SpliterRegex::SELECTOR_END, 'selector end', SelectorEndParserNode],
    [SpliterRegex::VARIABLE_ASSINMENT, 'variable assinment', VariableAssinmentParserNode],
    [SpliterRegex::PROP_WITH_VALUE, 'property with variable', PropertyWithVariableParserNode],
    [SpliterRegex::MIXIN, 'mixin start', MixinStartParserNode],
    [SpliterRegex::MIXIN_USING, 'mixin using', MixinUsingParserNode]
  ].freeze

  def initialize(string)
    @string = string
  end

  def build
    arr = match_name(string)
    obj = arr[2]
    answer = arr[1]
    raise "undefined matcher for #{string}" if answer.nil?

    obj.new(answer, string)
  end

  private

  def match_name(string)
    NAME_DICTIONARY
      .select { |reg, _answer, _obj| reg =~ string }
      .first
  end
end
