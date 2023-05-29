class Ship
  attr_reader :name,
              :length,
              :health

  # This initializes the method with the name and length of the ship as required arguments.
  # It also sets the health of the ship to the length of the ship.
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # This method checks to see if the health of the ship is equal to 0.
  # If it is, it returns true, otherwise it returns false.
  def sunk?
    @health == 0
  end

  # This method subtracts 1 from the health of the ship unless the ship is sunk.
  # If the ship is sunk, it does nothing.
  # This method will be used when a coordinate is fired upon and a ship in that coordinate is hit.
  def hit
    @health -= 1 unless sunk?
  end
end
