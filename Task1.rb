# frozen_string_literal: true

def sort_numbers(numbers, order)
  if order == "asc"
    numbers.sort
  elsif order == "desc"
    numbers.sort.reverse
  else
    puts "Incorrect input. Enter \"asc\" to sort in ascending order or \"desc\" to sort in descending order"
  end
end

#Enter the numbers in format: "1 2 3 4"
#Enter "asc" to sort in ascending order, "desc" to sort in descending order

if ARGV.length != 2
  puts "Incorrect input. Enter the numbers in format: \"1 2 3 4\".
         Enter \"asc\" to sort in ascending order, \"desc\" to sort in descending order"
  exit
end

numbers = ARGV[0].split(" ").map(&:to_i)
order = ARGV[1]

sorted_numbers = sort_numbers(numbers, order)

if sorted_numbers
  puts "Sorted numbers: #{sorted_numbers.join(', ')}"
end
