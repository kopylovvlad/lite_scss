require './parser/lscss_parser'
require './transformer/lscss_transformer'
require './compiler/lscss_compiler'

module LSCSS
  class MainMachine
    attr_accessor :input

    def initialize(input)
      @input = input
    end

    def perform
      # parse
      lscss_ast = LSCSSParser.new(input).perform

      # transform
      ast = LSCSSTransformer.new(lscss_ast).perform

      # compile
      output = LSCSSCompiler.new(ast).run

      output
    end
  end
end
