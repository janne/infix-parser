require_relative './parser'

loop do
  print "> "
  puts Parser.new(gets.strip).eval
end

