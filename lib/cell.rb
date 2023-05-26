class Cell
  attr_reader :coordinate,
              :ship

  # Initialize a cell with a coordinate and no ship to start
  def initialize(coordinate)
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
end
