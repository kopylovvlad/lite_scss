class AstTransformer
  attr_accessor :input_ast

  def initialize(input_ast)
    @input_ast = input_ast
  end

  def perform
    transform
  end

  def transform
    new_ast = []
    input_ast.each do |node|
      if node.nested?
        node.transform_nested.each { |item| new_ast.push(item) }
      else
        new_ast.push(node)
      end
    end
    new_ast
  end
end
