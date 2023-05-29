class Board
  attr_reader :cells

  # Initializes with an optional size argument (default 4)
  def initialize(size = 4)
    @cells = {} # Create empty hash to store cells
    # This is a nested loop that creates a cell for each coordinate
    # First the letter is converted to an integer
    # The loop iterates over a range of letters from A to the size of the board
    # The numbers are created by iterating through the size
    # The coordinate is created by concatenating the letter and number
    # The cell is created and stored in the hash with the coordinate as the key
    # The loop continues until all coordinates are created
    ('A'..('A'.ord + size - 1).chr).each do |letter|
      (1..size).each do |number|
        coordinate = letter + number.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  # This method returns true if a given coordinate exists as a key in the @cells hash
  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  # This method checks if a given ship can be placed on the board using the provided coordinates
  # The ship length must match the number of coordinates
  # The coordinates must be consecutive either horizontally or vertically -
  #   - this is checked using the private method consecutive_coordinates?
  # The coordinates must not contain a ship
  #   - This is checked by using the none? method with a block that checks if the ship attribute of each cell is true
  def valid_placement?(ship, coordinates)
    coordinates.length == ship.length && consecutive_coordinates?(coordinates) && coordinates.none? { |coordinate| @cells[coordinate].ship }
  end

  # This method places a ship on the board using the provided coordinates
  # First it checks if the placement is valid by using the valid_placement? method
  # If the placement is valid, this iterates over the coordinates and calls the place_ship method-
  #  - on the corresponding cell object passing the ship as an argument
  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end
  # This marks the following methods as private meaning it can only be called within this class
  # This is done to enforce encapsulation which hides this functionality from outside the class
  # It also prevents the methods from being called in the wrong context in another class

  private

  # This private method checks if the coordinates are consecutive either horizontally or vertically
  # First it extracts the letters and numbers from the coordinates
  # Next it checks if the letters are the same
  #   If they are, it checks if the numbers are consecutive
  #   If they are not...
  # It checks if the numbers are the same
  #   If they are, it checks if the letters are consecutive
  #   If they are not, it returns false
  #   If they are, it returns true
  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coordinate| coordinate[0] }
    numbers = coordinates.map { |coordinate| coordinate[1..-1].to_i }

    if letters.uniq.size == 1
      numbers.each_cons(2).all? { |x, y| y == x + 1 }
    elsif numbers.uniq.size == 1
      letters.map(&:ord).each_cons(2).all? { |x, y| y == x + 1 }
    else
      false
    end
  end
end
