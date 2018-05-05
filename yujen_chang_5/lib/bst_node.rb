class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def remove(child)
    if child == @left
      @left = nil
    elsif child == @right
      @right = nil
    end
  end
end
