require_relative 'command'

class DivideCommand < Command
  def initialize(operand_a, operand_b)
    @operand_a = operand_a
    @operand_b = operand_b
  end

  def execute
    if @operand_b.zero?
      raise "Ділення на нуль неможливе"
    else
      @operand_a / @operand_b.to_f
    end
  end
end
