module Utils
  def generate_new_names(item, name)
    item_names = item.name.split(',').map(&:strip)
    item_names.map { |i_n| "#{name} #{i_n}" }
  end

  def names(array)
    array.name.split(',').map(&:strip)
  end

  def props?(tree)
    !tree.select(&:not_selector?).empty?
  end
end
