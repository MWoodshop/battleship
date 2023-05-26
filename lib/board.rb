class Board
  attr_reader :cells

  include CoordinateValidation

  def initialize
    @cells = {}
    rows = %w[A B C D]
    columns = [1, 2, 3, 4]

    rows.each do |row|
      columns.each do |column|
        coordinate = "#{row}#{column}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  # Method tests is placement is valid based on several conditions
  def valid_placement?(ship, coordinates)
    # The coordinates argument from the test or player must be an array
    return false unless coordinates.is_a?(Array)
    # The ship argument must be Ship object
    return false unless ship.is_a?(Ship)
    # The coordinates length must be equal to the ship length
    return false if coordinates.length != ship.length

    # Iterate over each coordinate in the coordinates array
    coordinates.each do |coordinate|
      # Check if each coordinate is valid per valid_coordinate? method
      return false unless valid_coordinate?(coordinate)
      # Check that the cell object is not empty
      return false unless @cells[coordinate].empty?
    end
    # If all of the above do not fail, return true
    true
  end
end
