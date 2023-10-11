# frozen_string_literal: true

def cut(cake)
  n = cake.join.scan("0").count       # Raisins
  s = cake.length*cake[0].length      # S of cake
  s0=s/n                              # S of slice

  raise "The number of raisins must be greater than 1 and less than 10." unless n > 1 && n < 10
  raise "Cake can`t be cut`" unless s%n==0

=begin      # A simpler option for the case when the cake can be divided into tiers
  (1...cake[0].length).each do |width|
    cake_slices = cake.map { |line| line.scan(/.{#{width}}/) }

      if cake_slices.all? { |slice| slice.join.include?("0") }
        possible_slices << cake_slices
      end
  end

  return possible_slices.max_by { |slices| slices[0][0].length }
=end


  possible_slices=split_cake(cake,s0)   # Getting all possible pieces with a raisin

  valid_slices = possible_slices.combination(n).select do |combo|   # Identifying combinations of cut slices, with which can make a primary cake
    fit_slices(cake.map(&:dup), combo)
  end

  valid_slices.max_by { |slices| slices[0][0].length }              # Return the combination with the widest first slice
end

def split_cake(cake,s0)     # The method of dividing into rectangles, obtaining all possible slices
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


def get_slice(cake, length, width, start_row, start_col)    # Obtaining one piece by coordinates and length and width
  slice = []

  (start_row...(start_row + length)).each do |i|
    row = cake[i][start_col...(start_col + width)]
    slice << row
  end

  slice
end

def fit_slices(original, slices, fitted = [])   # Placement of cut pieces, backtracking
  if fitted.size == slices.size                 # If all slices are placed
    return true
  end

  slice_to_fit = slices[fitted.size]
  height = slice_to_fit.size
  width = slice_to_fit[0].length

  (0..(original.size - height)).each do |i|
    (0..(original[0].length - width)).each do |j|
      if can_place?(original, slice_to_fit, i, j)
        new_original = place_slice(original.map(&:dup), slice_to_fit, i, j)

        return true if fit_slices(new_original, slices, fitted + [slice_to_fit])
      end
    end
  end

  false
end

def can_place?(cake, slice, row, col)       # If a slice can be placed on the cake
  slice.each_with_index do |slice_row, i|
    slice_row.chars.each_with_index do |char, j|
      if (char == '0' && cake[row + i][col + j] != '0') || (char == '0' && (row + i >= cake.length || col + j >= cake[0].length))
        # If it's a raisin and it doesn't match the raisin on the cake, or if it've gone beyond the cake
        return false
      end
    end
  end
  true
end

def place_slice(cake, slice, row, col)      # Placement of slice
  slice.each_with_index do |slice_row, i|
    slice_row.chars.each_with_index do |char, j|
      if char == '0'
        cake[row + i][col + j] = '.'         # Replacing the raisin with a dot to indicate that this part of the cake has already been cut
      end
    end
  end
  cake
end

cake=[".0......",
      "......0.",
      "....0...",
      "..0....."]

result = cut(cake)
result.each do |slice|
  puts slice
  puts "\n"
end