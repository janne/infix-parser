require 'node'

class Parser
  Operation = Struct.new(:presedence, :method)

  OPERATIONS = {
    "+" => Operation.new(1, :add),
    "-" => Operation.new(1, :sub),
    "*" => Operation.new(2, :mul),
    "/" => Operation.new(2, :div),
  }

  def initialize(line)
    @infix = Parser.parse(line)
  end

  def eval
    stack = []
    postfix.each do |token|
      if op = Parser::OPERATIONS[token]
        stack.push send(op.method, *[stack.pop, stack.pop].reverse)
      else
        stack.push token
      end
    end
    stack.pop
  end

  def mul(a, b)
    a * b
  end

  def add(a, b)
    a + b
  end

  def sub(a, b)
    a - b
  end

  def div(a, b)
    a / b
  end

  def infix
    @infix
  end

  def tree
    stack = []
    postfix.each do |token|
      if op = Parser::OPERATIONS[token]
        stack.push Node.new(op) << stack.pop << stack.pop
      else
        stack.push token
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
        elsif operation = Parser::OPERATIONS[token]
          while (peeked = stack.last) && peeked != '(' && operation.presedence <= Parser::OPERATIONS[peeked].presedence
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
