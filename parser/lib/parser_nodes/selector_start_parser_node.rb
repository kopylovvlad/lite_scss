require './parser/lib/parser_nodes/abstract_parser_node'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_node_value'

class SelectorStartParserNode < AbstractParserNode
  def transform
    ::AstNodeBuilder.new(
      'Selector.new',
      value.tr('{', '').strip,
      [],
      AstNodeValue.new('', '')
    ).build
  end
end
