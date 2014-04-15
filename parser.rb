class Parser
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
        if token =~ /^\d+$/
          output << token
        else
          stack.push token
        end
      end
      output << stack.pop while !stack.empty?
    end
  end

  def self.parse(line)
    line.scan(/\W|\w+/).select{|s| s != ' '}
  end
end
