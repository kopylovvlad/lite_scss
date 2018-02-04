require './transformer/lib/ast_nodes/abstract_ast_node'

class PropertyAstNode < AbstractAstNode
  def transform_for_machine
    ::Property.new(name, value.transform_for_machine)
  end
end
