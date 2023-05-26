class Board
  attr_reader :cells

  include CoordinateValidation

  def initialize
    @cells = {}
  end
end
