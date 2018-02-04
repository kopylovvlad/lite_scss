##
# ast to machine for CssMachine
class AstToMachine
  attr_accessor :ast

  def initialize(ast)
    @ast = ast
  end

  def perform
    ast.map(&:transform_for_machine)
  end
end
