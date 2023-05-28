require 'rspec'
require './lib/ship'
require './lib/cell'

class Board
  attr_accessor :cell_hash

  def initialize
    @cell_hash = cells
  end

  def cells
    @cells ||= {
      'A1' => Cell.new('A1'),
      'A2' => Cell.new('A2'),
      'A3' => Cell.new('A3'),
      'A4' => Cell.new('A4'),
      'B1' => Cell.new('B1'),
      'B2' => Cell.new('B2'),
      'B3' => Cell.new('B3'),
      'B4' => Cell.new('B4'),
      'C1' => Cell.new('C1'),
      'C2' => Cell.new('C2'),
      'C3' => Cell.new('C3'),
      'C4' => Cell.new('C4'),
      'D1' => Cell.new('D1'),
      'D2' => Cell.new('D2'),
      'D3' => Cell.new('D3'),
      'D4' => Cell.new('D4')
    }
  end

  def valid_coordinate?(coordinate)
    @cell_hash.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinate_array)
    return false unless coordinate_array.is_a?(Array) # check if coordinate_array is an array
    return false unless ship.is_a?(Ship)              # check if ship is an instance of ship
    return false unless coordinate_array.length == ship.length # check if coordinate_array is equal to ship length

    letter = [] # stores letters of the coordinate
    number = [] # stores numbers of the coordinate

    coordinate_array.each do |element|
      return false unless valid_coordinate?(element) # checks if each elsement in coordinate_array is valid
      return false unless cell_hash[element].empty?  # checks if the cell is empty

      return false unless element.chars.length == 2

      letter << element.chars[0] # takes first character of element and adds to letter
      number << element.chars[1].to_i # takes second charater and turns it to int and adds to number

      # if the element does not have 2 charaters returns false
    end

    if ship.length == 3
      if letter[0] == letter[1] && letter[0] != letter[2] # check if first two letters are the same and last if different
        return false if number[0] == number[1] || number[0] == number[2] # check if the first number is the same as the second or third number
      elsif letter[0] != letter[1] && letter[0] != letter[2] # check if all three letters are different
        return false if number[0] != number[1] || number[0] != number[2] # check if all three numbers are different
      end

      if letter[0] != letter[1]
        return false if number[0] != number[1] && number[0] != number[2] # check if the first letter is different from the second and the first number is different from both the second and third
      elsif letter[0] != letter[2]
        return false if number[0] != number[1] && number[0] != number[2] # check if the first letter is different from the third and the first number is different from both the second and third
      end

      return false if letter[1] != letter[2] && letter[0] == letter[2] # check if the second and third letters are different and the first and third letters are the same

    elsif ship.length == 2
      return false if letter[0] != letter[1] && number[0] != number[1] # check if both letters and numbers are different for the two coordinates
    end

    ship.length.times do |location|
      return false if letter[location].ord >= 69
      return false if number[location] < 0 || number[location] > 5 # check if the number is less than 0 or greater than 5 since it's not a valid coordinate
      break unless number[location + 1] && letter[location + 1] # break the loop if the next location is out of bounds

      if (number[location + 1] - number[location]) != 1 && letter[location] == letter[location + 1] # check if the numbers are not consecutive and the letters are the same
        return false
      elsif (number[location + 1] - number[location]) != 1 && letter[location + 1].ord - letter[location].ord != 1 # check if the numbers are not consecutive and the letters are not consecutive
        return false
      elsif (letter[location + 1].ord - letter[location].ord) != 1 && (number[location + 1] - number[location]) != 1 # check if the letters are not consecutive and the numbers are not consecutive
        return false
      elsif (letter[location + 1].ord - letter[location].ord) == 1 && (number[location + 1] - number[location]) == 1 # check if both the letters and numbers are consecutive
        return false
      end
    end

    true
  end

  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each do |coordinate|
      cell = @cells[coordinate]
      cell.place_ship(ship)
    end
  end
end
