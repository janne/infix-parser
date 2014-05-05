$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'parser'

loop do
  print "> "
  puts Parser.new(gets.strip).eval
end

