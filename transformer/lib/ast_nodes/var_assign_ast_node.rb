require './transformer/lib/ast_nodes/abstract_ast_node'

class VarAssignAstNode < AbstractAstNode
  def transform_for_machine
    ::VariableAssign.new(name.to_sym, value.transform_for_machine)
  end
end
