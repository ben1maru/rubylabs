require_relative 'command'

class MultiplyCommand < Command
  def initialize(operand_a, operand_b)
    @operand_a = operand_a
    @operand_b = operand_b
  end

  def execute
    @operand_a * @operand_b
  end
end
