require './parser/lib/spliter_parser'
require './parser/lib/spliter_nodes_transformer'

class LSCSSParser
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def perform
    transform_to_nodes(spliter_text(input))
  end

  # split text to array of ParserNodes
  def spliter_text(input)
    SpliterParser.new(input).perform
  end

  # transform ParserNode to AstNode
  def transform_to_nodes(input)
    SpliterNodesTransformer.new(input).perform
  end
end
