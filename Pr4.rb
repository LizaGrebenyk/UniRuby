# frozen_string_literal: true

$values = {'M'=>1000, 'CM'=>900, 'D'=>500, 'CD'=>400, 'C'=>100, 'XC'=>90,
           'L'=>50, 'XL'=>40, 'X'=>10, 'IX'=>9, 'V'=>5, 'IV'=>4, 'I'=>1}

def int_to_roman(num)
  raise "The number must be between 1 and 3999" unless (1..3999).cover?(num)

  result = ""

  while num > 0
    $values.each do |symbol, value|
      while num >= value
        result += symbol
        num -= value
      end
    end
  end

  result
end

def roman_to_int(num)
  raise "Roman numeral format is incorrect" unless num.match?(/\A[M|D|C|L|X|V|I]+\z/)

  result = 0
  prev_value = 0

  num.each_char do |c|
    curr_value = $values[c]

    if curr_value > prev_value
      result += curr_value - 2 * prev_value
    else
      result += curr_value
    end

    prev_value = curr_value
  end

  result
end

if ARGV.length != 2
  puts "Enter 2 numbers: int and roman formats"
  exit
end

puts int_to_roman(ARGV[0].to_i)
puts roman_to_int(ARGV[1])