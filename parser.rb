class Parser
  def initialize(line)
    @infix = Parser.parse(line)
  end

  def infix
    @infix
  end

  def self.parse(line)
    line.scan(/\W|\w+/).select{|s| s != ' '}
  end
end
