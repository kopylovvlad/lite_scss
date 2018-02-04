require './transformer/lib/ast_nodes/abstract_ast_node'

class MixinAstNode < AbstractAstNode
  def transform_for_machine
    ::Mixin.new(name.to_sym)
  end
end
