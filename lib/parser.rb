require 'node'
require 'operand'

class Parser
  def initialize(line)
    @infix = Parser.parse(line)
  end

  def eval
    tree.eval
  end

  def infix
    @infix
  end

  def tree
    stack = []
    postfix.each do |token|
      if op = Operand.find(token)
        stack.push Node.new(op, stack.pop(2))
      else
        stack.push Node.new(token)
      end
    end
    stack.pop
  end

  def postfix
    @postfix ||= [].tap do |output|
      stack = []
      @infix.each do |token|
        if token == '('
          stack.push(token)
        elsif token == ')'
          while (popped = stack.pop) && popped != '('
            output << popped
          end
        elsif operation = Operand.find(token)
          while (peeked = stack.last) && peeked != '(' && operation.presedence <= Operand.find(peeked).presedence
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
    line.scan(/\W|[\w.]+/).select{|s| s != ' '}.map do |s|
      if s =~ /^\d+$/
        s.to_i
      elsif s =~ /^[-+]?[0-9]*\.?[0-9]+$/
        s.to_f
      else
        s
      end
    end
  end
end
