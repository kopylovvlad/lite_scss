###
# some utils for SpliterNodesTransformer
module SntUtils
  private

  def any_start?(node)
    node.mixin_start? || node.selector_start?
  end

  def check_property?(node)
    node.property? or node.property_with_variable?
  end

  def children_last_recursive(item, sub_level)
    if sub_level.zero?
      item
    else
      children_last_recursive(item.children.last, sub_level - 1)
    end
  end

  def valid_node?(node)
    (any_start?(node) || check_property?(node) ||
      node.mixin_using? || any_close?(node) ||
      node.variable_assinment?)
  end

  def any_close?(node)
    close_selector?(node) || close_mixin?(node)
  end
end
