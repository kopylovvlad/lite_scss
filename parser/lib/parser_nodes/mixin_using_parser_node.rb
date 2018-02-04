require './parser/lib/parser_nodes/abstract_parser_node'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_node_value'

class MixinUsingParserNode < AbstractParserNode
  def transform
    ::AstNodeBuilder.new(
      'Mixin.new',
      value.gsub('@include', '').tr(';', '').strip,
      [],
      AstNodeValue.new('', '')
    ).build
  end
end
