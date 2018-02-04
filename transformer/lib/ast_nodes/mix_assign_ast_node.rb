require './transformer/lib/ast_nodes/abstract_ast_node'

class MixAssignAstNode < AbstractAstNode
  def transform_for_machine
    ::MixinAssign.new(name.to_sym, children.map(&:transform_for_machine))
  end
end
