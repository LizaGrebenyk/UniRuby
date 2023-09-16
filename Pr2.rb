# Зробити невеликий скрипт
# На вхід передаємо математичний вираз у звичному нам вигляді
# На виході бачимо його у RPN
#
# EX:
# input --> 2 + 1 × 4
# output --> 2 1 4 * +

$operator_preced = {'+' => 1, '-' => 1, '*' => 2, '/' => 2}

def rpn(expres)
  output = []
  operators = []

  expres.each do |token|
    case token
    when /\d/
      output.push(token)
    when '('
      operators.push(token)
    when ')'
      output.push(operators.pop) while operators.last != '('
      operators.pop
    else
      operator_priority(operators,output,token)
    end
  end

  while !operators.empty?
    output.push(operators.pop)
  end

  return output.join(' ')
end

def operator_priority(operators,output,token)
  while !operators.empty? && operators.last != '(' && $operator_preced[operators.last] >= $operator_preced[token]
    output.push(operators.pop)
  end
    operators.push(token)
end

if ARGV.length!=1
  puts "The mathematical expression must be a string with spaces between numbers and operands"
  exit
end

input_expres = ARGV[0].split
puts output_rpn = rpn(input_expres)