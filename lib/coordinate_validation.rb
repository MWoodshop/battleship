# This module defines the valid battleship coordinates using regex.
# This can be called in any class where this should be validated.
# The project instructions defines the grid as the following:
#    A   B   C   D
# 1 |_| |_| |_| |_|
# 2 |_| |_| |_| |_|
# 3 |_| |_| |_| |_|
# 4 |_| |_| |_| |_|

module CoordinateValidation
  VALID_COORDINATE_REGEX = /^[A-D][1-4]$/

  def validate_coordinate(coordinate)
    raise ArgumentError, 'Invalid coordinate format, coordinate must be one of these letters (A, B, C, D) and one of these numbers (1, 2, 3, 4)' unless coordinate.match?(VALID_COORDINATE_REGEX)

    column = coordinate[0]
    row = coordinate[1..-1].to_i

    return if ('A'..'D').include?(column) && (1..4).include?(row)

    raise ArgumentError, 'Invalid coordinate, coordinate out of bounds.'
  end
end
