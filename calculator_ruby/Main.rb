
$memory = nil

def prompt(message)
  print message
end

def memory_write(result)
  $memory = result
end

def memory_read
  $memory
end

def get_number
  loop do
    input = gets.chomp
    return input.to_f if input.match(/^\d+(\.\d+)?$/)
    print("Це не число. Будь ласка, введіть число: ")
  end
end

def unary_operation(number)
  loop do
    print("Оберіть унарну операцію:\n1. Корінь квадратний\n2. Логарифм\n3. Піднесення до квадрату\nВаш вибір: ")
    operation = gets.chomp.downcase
    case operation
    when "1"
      return Math.sqrt(number)
    when "2"
      return Math.log(number)
    when "3"
      return number ** 2
    else
      print("Невірна операція. Спробуйте ще раз.\n")
    end
  end
end

def binary_operation(number1, number2)
  loop do
    print("Оберіть бінарну операцію:\n1. Додавання\n2. Віднімання\n3. Множення\n4. Ділення\nВаш вибір: ")
    operation = gets.chomp
    case operation
    when "1"
      return number1 + number2
    when "2"
      return number1 - number2
    when "3"
      return number1 * number2
    when "4"
      if number2.zero?
        print("На нуль ділити не можна. Будь ласка, введіть друге число: ")
      else
        return number1 / number2
      end
    else
      print("Невірна операція. Спробуйте ще раз.\n")
    end
  end
end

number1 = nil

loop do
  if number1.nil?
    print("Введіть перше число: ")
    number1 = get_number
  else
    print("Бажаєте використати попередній результат (#{memory_read}) для наступних операцій? (1 - Так / 2 - Ні): ")
    choice = gets.chomp.downcase
    break unless choice == "1" || choice == "так"
    number1 = memory_read.to_f
  end

  if number1
    if number1.integer?
      print("Доступні операції:\n1. Корінь квадратний\n2. Логарифм\n3. Піднесення до квадрату\n")
      result = unary_operation(number1)
    else
      print("Введіть друге число або натисніть Enter для продовження з першим числом: ")
      number2_input = gets.chomp
      if number2_input.empty?
        result = unary_operation(number1)
      else
        number2 = number2_input.to_f
        result = binary_operation(number1, number2)
      end
    end

    puts "Результат: #{result}\n"

    memory_write(result)
    
  else
    print("Помилка. Будь ласка, введіть число.\n")
  end
end
