# machine
# make css from AST
class LSCSSCompiler
  attr_accessor :expression, :environment

  def initialize(expression)
    @expression = expression
    @environment = {}
  end

  def run
    reduced_exps = expression.map do |ex|
      ex, self.environment = ex.reduce(environment) if ex.reducible?
      ex
    end

    items = reduced_exps.map { |ex| ex.printable? ? ex.to_s : nil }

    items.delete(nil)

    items.join("\n").gsub("\n\r", "\n")
  end
end
