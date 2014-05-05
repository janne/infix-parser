class Operand
  attr_reader :presedence, :method

  def initialize(presedence, method)
    @presedence = presedence
    @method = method
  end

  MAP = {
    "+" => Operand.new(1, :add),
    "-" => Operand.new(1, :sub),
    "*" => Operand.new(2, :mul),
    "/" => Operand.new(2, :div),
  }

  def self.find(token)
    MAP[token]
  end

  def call(*args)
    send(@method, *args)
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
end
