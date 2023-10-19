def generate_password(length)
  characters = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
  password = (0...length).map { characters.sample }.join
end

length = ARGV[0].to_i

if length > 0
  password = generate_password(length)
  puts "Generated password: #{password}"
else
  puts "Incorrect input. Enter a positive number"
end
