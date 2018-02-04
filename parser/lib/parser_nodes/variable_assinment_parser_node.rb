require './parser/lib/spliter_regex'
require './parser/lib/parser_nodes/abstract_parser_node'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_node_value'

class VariableAssinmentParserNode < AbstractParserNode
  def transform
    ::AstNodeBuilder.new(
      'VariableAssign.new',
      variable_name,
      [],
      ::AstNodeValue.new('VirtualString.new', variable_value)
    ).build
  end

  private

  def variable_name
    match_value(SpliterRegex::VARIABLE_NAME).tr('$', '').strip
  end

  def variable_value
    std_gsub(match_value(SpliterRegex::VARIABLE_VALUE))
  end
end
