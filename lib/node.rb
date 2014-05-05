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
end
