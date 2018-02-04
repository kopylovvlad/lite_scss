require './transformer/lib/ast_nodes/abstract_ast_node'

class SelectorAstNode < AbstractAstNode
  def transform_for_machine
    ::Selector.new(name, children.map(&:transform_for_machine))
  end
end
