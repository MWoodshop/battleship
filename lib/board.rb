class Board
  attr_reader :cells

  # !!! In refactor - readd comments to methods !!!

  def initialize(size = 4)
    @cells = {}
    ('A'..('A'.ord + size - 1).chr).each do |letter|
      (1..size).each do |number|
        coordinate = letter + number.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    coordinates.length == ship.length && consecutive_coordinates?(coordinates) && coordinates.none? { |coordinate| @cells[coordinate].ship }
  end

  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  private

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
