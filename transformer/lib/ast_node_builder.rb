Dir['./transformer/lib/ast_nodes/*.rb'].each { |file| require file }

class AstNodeBuilder
  attr_reader :class_name, :name, :children, :value

  DICTIONARY = [
    ['Selector.new', SelectorAstNode],
    ['Property.new', PropertyAstNode],
    ['VariableAssign.new', VarAssignAstNode],
    ['MixinAssign.new', MixAssignAstNode],
    ['Mixin.new', MixinAstNode]
  ].freeze

  def initialize(class_name, name, children, value)
    @class_name = class_name
    @name = name
    @children = children
    @value = value
  end

  def build
    _s, obj = DICTIONARY.select { |s, _obj| s == class_name }.first
    raise "undefined class_name: #{class_name}" if obj.nil?

    obj.new(class_name, name, children, value)
  end
end
