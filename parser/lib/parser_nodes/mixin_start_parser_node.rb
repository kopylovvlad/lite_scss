require './parser/lib/parser_nodes/abstract_parser_node'
require './transformer/lib/ast_node_builder'
require './transformer/lib/ast_node_value'

class MixinStartParserNode < AbstractParserNode
  def transform
    ::AstNodeBuilder.new(
      'MixinAssign.new',
      value.gsub('@mixin', '').tr('{', '').strip,
      [],
      AstNodeValue.new('', '')
    ).build
  end
end
