require_relative 'command'
require_relative 'plus_command'
require_relative 'minus_command'
require_relative 'multiply_command'
require_relative 'divide_command'

print "Введіть перше число: "
operand_a = gets.to_i

print "Введіть друге число: "
operand_b = gets.to_i

print "Введіть операцію (+, -, *, /): "
operation = gets.chomp

command =
  case operation
  when "+"
    PlusCommand.new(operand_a, operand_b)
  when "-"
    MinusCommand.new(operand_a, operand_b)
  when "*"
    MultiplyCommand.new(operand_a, operand_b)
  when "/"
    DivideCommand.new(operand_a, operand_b)
  else
    raise "Непідтримувана операція"
  end

# Виконання команди та виведення результату
result = command.execute
puts "Результат: #{result}"
