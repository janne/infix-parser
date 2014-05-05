class Node
  attr_reader :content, :children

  def initialize(content, children = [])
    @content = content
    @children = children
  end

  def eval
    if content.is_a?(Operand)
      content.call *children.map(&:eval)
    else
      content
    end
  end
end
