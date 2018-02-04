require './parser/lib/snt_utils'

###
# transform ParserNodes array to AST
class SpliterNodesTransformer
  include SntUtils

  def initialize(nodes)
    @nodes = nodes
    @level = 0
    @current_mode = ''
    @ast = []
    @tmp_node = nil
  end

  def perform
    @nodes.each do |node|
      if valid_node?(node)
        transform(node)
      else
        raise 'undefined Node.name: ' \
          "#{node.name} (#{node.value}) " \
          "with mode: #{@current_mode}"
      end
    end
    @ast
  end

  private

  def transform(node)
    if node.selector_start?
      start_create_selector(node)

    elsif check_property?(node)
      add_property(node)

    elsif node.mixin_using?
      add_mixin_using(node)

    elsif close_selector?(node)
      close_selector

    elsif close_mixin?(node)
      close_mixin

    elsif node.variable_assinment?
      add_var_assign(node)

    elsif node.mixin_start?
      create_mixin(node)
    end
  end

  def close_selector?(node)
    node.selector_end? and ['create selector', 'close selector'].include?(@current_mode)
  end

  def close_mixin?(node)
    node.selector_end? and @current_mode == 'create mixin'
  end

  def add_mixin_using(node)
    choose_deep_tmp_node(@tmp_node)
      .push(node.transform)
  end

  def add_var_assign(node)
    @ast.push(node.transform)
  end

  def start_create_selector(node)
    item = node.transform
    if @level.positive?
      choose_deep_tmp_node(@tmp_node).push(item)
    else
      @tmp_node = item
    end
    @current_mode = 'create selector'
    @level += 1
  end

  def close_selector
    @ast.push(@tmp_node) unless @level > 1
    @current_mode = 'close selector'
    @level -= 1
  end

  def close_mixin
    @ast.push(@tmp_node)
    @current_mode = 'close mixin'
  end

  def create_mixin(node)
    @tmp_node = node.transform
    @current_mode = 'create mixin'
  end

  def add_property(node)
    choose_deep_tmp_node(@tmp_node)
      .push(node.transform)
  end

  def choose_deep_tmp_node(tmp_node)
    if @level.positive?
      children_last_recursive(tmp_node, @level - 1).children
    else
      tmp_node.children
    end
  end
end
