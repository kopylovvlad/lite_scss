require './transformer/lib/ast_to_machine'
require './transformer/lib/ast_transformer'

class LSCSSTransformer
  attr_accessor :input_tree

  def initialize(input_tree)
    @input_tree = input_tree
  end

  def perform
    create_ast(transform_ast(input_tree))
  end

  def create_ast(input)
    AstToMachine.new(input).perform
  end

  def transform_ast(input)
    AstTransformer.new(input).perform
  end
end
