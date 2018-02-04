Dir['./parser/lib/parser_nodes/*.rb'].each { |file| require file }
require './parser/lib/parser_node_builder'

##
# parser document to one-level array of ParserNode
class SpliterParser
  attr_accessor :document

  def initialize(document)
    @document = document
  end

  def perform
    # delete comments
    document.gsub!(%r{\/\*([^\/\*]|\/\*|\*)*\*\/}im, '')

    # split by ';' or '{' or '}'
    document_pieces = document.split(/(?<=;|{|})/)

    # pattern matching every pieces
    mathings = document_pieces.map do |i|
      next if i.strip.empty?
      match_part(i.strip)
    end

    mathings.delete(nil)
    mathings
  end

  private

  def match_part(string)
    ParserNodeBuilder.new(string).build
  end
end
