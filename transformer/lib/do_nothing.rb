class DoNothing
  def to_s
    'do-nothing'
  end

  def ==(other)
    other.instance_of?(DoNothing)
  end

  def reducible?
    false
  end

  def printable?
    false
  end
end
