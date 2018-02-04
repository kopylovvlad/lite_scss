require './transformer/lib/selector'
require './transformer/lib/property'
require './transformer/lib/variable_assign'
require './transformer/lib/mixin_assign'
require './transformer/lib/mixin'
require './transformer/lib/nested_ast_node_transformer'

###
# Abstract syntax tree node
class AbstractAstNode
  attr_accessor :children, :class_name, :name, :value

  def initialize(class_name, name, children, value)
    @class_name = class_name
    @name = name
    @children = children
    @value = value
  end

  def ==(other)
    (other.is_a?(AbstractAstNode) &&
      other_to_a(other) == [class_name, name, children, value])
  end

  def transform_for_machine
    raise '"transform_for_machine" does not implement error'
  end

  def selector?
    class_name == 'Selector.new'
  end

  def property?
    class_name == 'Property.new'
  end

  def var_assign?
    class_name == 'VariableAssign.new'
  end

  def mix_assign?
    class_name == 'MixinAssign.new'
  end

  def mixin?
    class_name == 'Mixin.new'
  end

  def not_selector?
    !selector?
  end

  def nested?
    !children.select(&:selector?).empty?
  end

  def transform_nested
    ::NestedAstNodeTransformer.new(self).perform
  end

  def reset_children!
    self.children = []
  end

  private

  def other_to_a(other)
    [other.class_name, other.name, other.children, other.value]
  rescue StandardError
    []
  end
end
