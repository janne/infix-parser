class Parser
  def initialize(line)
    @parsed = Parser.parse(line)
  end

  def length
    @parsed.length
  end

  def self.parse(line)
    line.scan(/\W|\w+/).select{|s| s != ' '}
  end
end
