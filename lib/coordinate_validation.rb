# This module defines the valid battleship coordinates using regex.
# This can be called in any class where this should be validated.
# The project instructions defines the grid as the following:
#    A   B   C   D
# 1 |_| |_| |_| |_|
# 2 |_| |_| |_| |_|
# 3 |_| |_| |_| |_|
# 4 |_| |_| |_| |_|

module CoordinateValidation
  # This is a constant that defines the valid battleship coordinates using regex.
  # The regex means that the coordinate must start with a letter A-D, and end with a number 1-4.
  VALID_COORDINATE_REGEX = /^[A-Z]{1}\d{1,2}$/

  # This method validates the coordinate format and checks if the coordinate is within the grid.
  def validate_coordinate(coordinate)
    # The match? method returns true if the regex matches the coordinate string given as an argument.
    # If the regex does not match the coordinate string given as an argument, the match? method returns false.
    # If the match? method returns false, the following error is raised.
    raise ArgumentError, 'Invalid coordinate format' unless coordinate.match?(VALID_COORDINATE_REGEX)

    # This extracts the first character from the coordinate string as column
    # then converts the rest of the coordinate string to an integer as row.
    column = coordinate[0]
    row = coordinate[1..-1].to_i
    # This checks if the column is A-D and the row is 1-4.
    # If the column is A-D and the row is 1-4, the method returns and no error is raised.
    return if ('A'..'D').include?(column) && (1..4).include?(row)

    # If the column is not A-D and the row is not 1-4, the following error is raised.
    raise ArgumentError, 'Invalid coordinate, coordinate out of bounds'
  end
end
