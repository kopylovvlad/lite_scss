require './transformer/lib/utils'
###
# service for transform nested-ast to standart ast
class NestedAstNodeTransformer
  attr_reader :root_names
  include Utils

  def initialize(ast_node)
    @ast_node = ast_node
    @new_ast_nodes = []
    @root_names = names(ast_node)
  end

  def perform
    save_props if props?(@ast_node.children)

    @ast_node.children.each do |item|
      perform_children(item) if item.selector?
    end
    @new_ast_nodes
  end

  private

  def perform_children(item)
    if item.nested?
      item.transform_nested.each do |nested_item|
        push_item(nested_item)
      end
    else
      push_item(item)
    end
  end

  def save_props
    tmp_node = @ast_node.dup
    tmp_node.reset_children!
    @ast_node.children.each do |item|
      tmp_node.children.push(item) unless item.selector?
    end
    @new_ast_nodes.push(tmp_node)
  end

  def push_item(item)
    # combinate
    new_name = root_names.map do |name|
      generate_new_names(item, name)
    end

    # set
    item.name = new_name.reduce(&:+).join(', ')

    # push
    @new_ast_nodes.push(item)
  end
end
