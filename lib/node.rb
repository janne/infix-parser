class Node
  attr_reader :content, :children

  def initialize(content)
    @content = content
    @children = []
  end

  def <<(child)
    @children << child
    self
  end

  def eval
    if content.is_a?(Operand)
      content.call *children.map(&:eval)
    else
      content
    end
  end
end
