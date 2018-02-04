require './parser/lib/spliter_regex'
require './parser/lib/parser_nodes/abstract_parser_node'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_node_value'

class PropertyWithVariableParserNode < AbstractParserNode
  def transform
    ::AstNodeBuilder.new(
      'Property.new',
      property_name,
      [],
      ::AstNodeValue.new('Variable.new', prop_to_var_val)
    ).build
  end

  private

  def prop_to_var_val
    std_gsub(match_value(SpliterRegex::VALUE_VAL).tr('$', ''))
  end
end
