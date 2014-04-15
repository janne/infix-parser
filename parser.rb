class Parser
  OPERATIONS = {
    "+" => 6,
    "-" => 6,
    "*" => 7,
    "/" => 7,
  }

  def initialize(line)
    @infix = Parser.parse(line)
  end

  def infix
    @infix
  end

  def postfix
    @postfix ||= [].tap do |output|
      stack = []
      @infix.each do |token|
        if presedence = Parser::OPERATIONS[token]
          while (peeked = stack.last) && presedence <= Parser::OPERATIONS[peeked]
            output << stack.pop
          end
          stack.push token
        else
          output << token
        end
      end
      output << stack.pop while !stack.empty?
    end
  end

  def self.parse(line)
    line.scan(/\W|\w+/).select{|s| s != ' '}
  end
end
