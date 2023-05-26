require './lib/coordinate_validation'

class Cell
  attr_reader :coordinate,
              :ship

  include CoordinateValidation

  # Initialize a cell with a coordinate and no ship to start
  def initialize(coordinate)
    validate_coordinate(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  # Check if a cell is empty
  def empty?
    @ship.nil?
  end

  # Place a ship in a cell
  def place_ship(ship)
    @ship = ship
  end

  # Fire upon a cell
  def fire_upon
    # The @ship&.hit means: the method call hit should only be performed if @ship is not null
    @ship&.hit
    @fired_upon = true
  end

  # Check if a cell has been fired upon
  def fired_upon?
    @fired_upon
  end

  def render(reveal_ship = false)
    # The cell has been fired upon and it does not contain a ship (the shot was a miss).
    return 'M' if fired_upon? == true && empty?
    # The cell has been fired upon and it contains a ship (the shot was a hit).
    return 'H' if fired_upon? == true && !empty? && !@ship.sunk?
    # The cell has been fired upon and its ship has been sunk.
    return 'X' if fired_upon? == true && !empty? && @ship.sunk?
    # The cell contains a ship that has not been fired upon and contains a ship.
    return 'S' if reveal_ship && !fired_upon? && !empty?

    # Otherwise return "." which means the cell was not fired upon.
    '.'
  end
end


