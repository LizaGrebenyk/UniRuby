# frozen_string_literal: true

def valid_ipv4?(ip)
  return false unless ip.match?(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) # Регулярний вираз, що перевіряє наявність чисел у кількості від 1 до 3 в рядку через крапку

  nums = ip.split('.')

  nums.all? { |num| (0..255).cover?(num.to_i) && num.to_i.to_s == num } # Перевірка, що числа не виходяять за межі 0-255, що немає ведучих нулів
end

if ARGV.length != 1
  puts "Enter an IPv4 address as a command line argument"
  exit
end

input_address = ARGV[0]

puts valid_ipv4?(input_address)