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
    # These two lines extract the row and column values from the coordinates array
    rows = coordinates.map { |coord| coord[0] }
    columns = coordinates.map { |coord| coord[1..].to_i }

    # Checks if the coordinates are consecutive in rows
    if rows.uniq.length == 1 && (columns.min..columns.max).to_a == columns.sort
      # If rows are the same and columns are consecutive
      rows.all? do |row|
        # Check each cell in the row is valid and empty
        valid_coordinate = valid_coordinate?("#{row}#{columns.min}")
        empty_cell = @cells["#{row}#{columns.min}"].empty?
        valid_coordinate && empty_cell
      end
    elsif columns.uniq.length == 1 && (rows.min.ord..rows.max.ord).to_a == rows.map(&:ord).sort
      # Checks if the coordinates are consecutive in columns
      columns.all? do |column|
        # Check each cell in the column is valid and empty
        valid_coordinate = valid_coordinate?("#{rows.min}#{column}")
        empty_cell = @cells["#{rows.min}#{column}"].empty?
        valid_coordinate && empty_cell
      end
    else
      false
    end
  end
end
