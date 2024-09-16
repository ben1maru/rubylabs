$stack = []

def prompt(message)
  print message
end

def push_to_stack(value)
  $stack.push(value)
end

def pop_from_stack
  $stack.pop
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
    result = case operation
             when "1"
               Math.sqrt(number)
             when "2"
               Math.log(number)
             when "3"
               number ** 2
             else
               print("Невірна операція. Спробуйте ще раз.\n")
               next
             end
    push_to_stack(result)
    puts(result)
    return result
  end
end

def binary_operation(number1, number2)
  loop do
    print("Оберіть бінарну операцію:\n1. Додавання\n2. Віднімання\n3. Множення\n4. Ділення\nВаш вибір: ")
    result = case gets.chomp
             when "1"
               number1 + number2
             when "2"
               number1 - number2
             when "3"
               number1 * number2
             when "4"
               if number2.zero?
                 print("На нуль ділити не можна. Будь ласка, введіть друге число: ")
                 next
               else
                 number1 / number2
               end
             else
               print("Невірна операція. Спробуйте ще раз.\n")
               next
             end
    push_to_stack(result)
             puts(result)
    return result
  end
end


def stack_operations(result)
  loop do
    puts "Вміст стеку: #{$stack.inspect}"
    print("Оберіть дію зі стеком:\n1. Вилучити останній результат (pop)\n2. Додати новий результат (push)\n3. Знайти найбільше просте число менше за результат (primes)\n4. Переглянути вміст стеку\nВаш вибір: ")
    choice = gets.chomp
    case choice
    when "1"
      popped_value = pop_from_stack
      puts "Вилучено зі стеку: #{popped_value}"
      return popped_value.nil? ? result : popped_value
    when "2"
      push_to_stack(result)
      puts "Додано до стеку: #{result}"
    when "3"
      prime_number = primes(result)
     
      pop_from_stack
      push_to_stack(prime_number) 
      puts "Найбільше просте число менше за #{result} є #{prime_number}"
      return prime_number
    when "4"
      puts "Вміст стеку: #{$stack.inspect}"
    else
      print("Невірна опція. Спробуйте ще раз.\n")
    end
  end
end


def primes(value)
  prime_number = get_prime_number(value)
  puts "Найближче просте число менше ніж #{value} є #{prime_number}"
  prime_number
end


def is_prime?(number)
  return false if number <= 1

  (2..Math.sqrt(number)).each { |n| return false if number % n == 0 }

  true
end

def get_prime_number(value)
  numbers = (1...value).to_a.sort { |a, b| b <=> a }
  numbers.each do |number|
    return number if is_prime?(number)
  end
  raise ArgumentError, "there is no prime number"
end


def main
  loop do
    print("Введіть число або 'exit' для виходу: ")
    input = gets.chomp.downcase
    break if input == "exit"
    
    if input.match(/^\d+(\.\d+)?$/)
      number1 = input.to_f
      result = process_number(number1)

      loop do
        print("1. Продовжити операції з результатом\n2. Робота зі стеком\n3. Нове обчислення\nВаш вибір: ")
        choice = gets.chomp
        case choice
        when "1"
          result = process_number(result)
        when "2"
          result = stack_operations(result)
        when "3", ""
          break
        else
          print("Невірна опція. ")
        end
      end
    else
      print("Невірний ввід. Будь ласка, введіть число.\n")
    end
  end
end

def process_number(number)
  if number.integer?
    print("Доступні операції:\n1. Корінь квадратний\n2. Логарифм\n3. Піднесення до квадрату\n")
    unary_operation(number)
  else
    print("Введіть друге число або натисніть Enter для продовження з першим числом: ")
    number2_input = gets.chomp
    if number2_input.empty?
      unary_operation(number)
    else
      number2 = number2_input.to_f
      binary_operation(number, number2)
    end
  end
end


main
