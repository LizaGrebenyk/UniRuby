# frozen_string_literal: true

def cut(cake)
  n = cake.join.scan("0").count       # Raisins
  s = cake.length*cake[0].length      # S of cake
  s0=s/n                              # S of slice

  raise "The number of raisins must be greater than 1 and less than 10." unless n > 1 && n < 10
  raise "Cake can`t be cut`" unless s%n==0

  #possible_slices = []

=begin
  (1...cake[0].length).each do |width|
    cake_slices = cake.map { |line| line.scan(/.{#{width}}/) }

      if cake_slices.all? { |slice| slice.join.include?("0") }
        possible_slices << cake_slices
      end
  end

  return possible_slices.max_by { |slices| slices[0][0].length }
=end


  possible_slices=split_cake(cake,s0)

  #return possible_slices.max_by { |slices| slices[0][0].length }
end

def split_cake(cake,s0)
  slices = []

  heightC = cake.length
  widthC = cake[0].length

  (1..heightC).each do |length|
    (1..widthC).each do |width|
      next if length*width!=s0
      (0...(heightC - length + 1)).each do |start_row|
        (0...(widthC - width + 1)).each do |start_col|
          slice = get_slice(cake, length, width, start_row, start_col)
          if slice.join.scan("0").count==1
            slices << slice
          end
        end
      end
    end
  end

  slices
end


def get_slice(cake, length, width, start_row, start_col)
  slice = []

  (start_row...(start_row + length)).each do |i|
    row = cake[i][start_col...(start_col + width)]
    slice << row
  end

  slice
end

cake=[".0......",
      "......0.",
      "....0...",
      "..0....."]

cake1=[".0.0....",
       "........",
      "....0...",
      "........",
      ".....0..",
      "........"]

result = cut(cake)
#puts result
result.each do |slice|
  puts slice
  puts "\n"
end