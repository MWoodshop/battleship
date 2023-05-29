require 'rspec'
require 'pry'
require './lib/cell'
require './lib/ship'
require './lib/board'

# Iteration 2

RSpec.describe Board do
  describe '#initialize' do
    it 'can initialize' do
      board = Board.new
      expect(board).to be_a(Board)
    end

    it 'returns empty hash' do
      board = Board.new
      expect(board.cells).to be_a(Hash)
    end

    it 'returns a coordinate as a cell' do
      board = Board.new

      expect(board.cells['A1']).to be_a Cell
    end

    it 'returns the expected grid' do
      board = Board.new

      expect(board.cells.keys).to include('A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4')
    end
  end

  describe 'valid_coordinate?' do
    it 'returns true' do
      board = Board.new

      expect(board.valid_coordinate?('A1')).to eq(true)
      expect(board.valid_coordinate?('D4')).to eq(true)
    end

    it 'returns false' do
      board = Board.new

      expect(board.valid_coordinate?('A5')).to eq(false)
      expect(board.valid_coordinate?('E1')).to eq(false)
      expect(board.valid_coordinate?('A22')).to eq(false)
    end
  end

  describe 'valid_placement?' do
    it 'returns boolean' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(cruiser, %w[A1 A2 A3])).to eq(true)
      expect(board.valid_placement?(cruiser, %w[A1 A2 A3 A4])).to eq(false)
    end

    it 'is not an array' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(cruiser, 'A1')).to eq(false)
    end

    it 'is not an array' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      fishing_boat = 'Invalid Ship'

      expect(board.valid_placement?(fishing_boat, %w[A1 A2 A3 A4])).to eq(false)
    end

    it 'coordinates.length is not equal to ship.length' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(submarine, %w[A2 A3 A4])).to eq(false)
    end

    it 'coordinate is empty' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(submarine, [])).to eq(false)
    end

    it 'test all ship placement' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(cruiser, %w[A1 A2])).to eq(false)
      expect(board.valid_placement?(submarine, %w[A2 A3 A4])).to eq(false)
      expect(board.valid_placement?(cruiser, %w[A1 A2 A4])).to eq(false)
      expect(board.valid_placement?(submarine, %w[A1 C1])).to eq(false)
      expect(board.valid_placement?(cruiser, %w[A3 A2 A1])).to eq(false)
      expect(board.valid_placement?(submarine, %w[C1 B1])).to eq(false)
      expect(board.valid_placement?(cruiser, %w[A1 B2 C3])).to eq(false)
      expect(board.valid_placement?(submarine, %w[C2 D3])).to eq(false)
      expect(board.valid_placement?(submarine, %w[A1 A2])).to eq(true)
      expect(board.valid_placement?(cruiser, %w[B1 C1 D1])).to eq(true)
    end
  end

  # Iteration 2 - Placing Ships
  describe '.place method' do
    it '.ship returns correct ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      cell_1 = board.cells['A1']
      cell_2 = board.cells['A2']
      cell_3 = board.cells['A3']

      expect(cell_1.ship.name).to eq('Cruiser')
      expect(cell_1.ship.length).to eq(3)
      expect(cell_1.ship.health).to eq(3)

      expect(cell_2.ship.name).to eq('Cruiser')
      expect(cell_2.ship.length).to eq(3)
      expect(cell_2.ship.health).to eq(3)

      expect(cell_3.ship.name).to eq('Cruiser')
      expect(cell_3.ship.length).to eq(3)
      expect(cell_3.ship.health).to eq(3)
    end

    it 'cell.ship of cells containing the same ship equal each other' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      cell_1 = board.cells['A1']
      cell_2 = board.cells['A2']
      cell_3 = board.cells['A3']

      expect(cell_1.ship == cell_2.ship).to eq(true)
      expect(cell_1.ship == cell_3.ship).to eq(true)
      expect(cell_2.ship == cell_3.ship).to eq(true)
    end

    it 'cell.ship of cells NOT containing the same ship do NOT equal each other' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      cell_1 = board.cells['A1']
      cell_2 = board.cells['A2']
      cell_3 = board.cells['A3']
      cell_4 = board.cells['A4']

      expect(cell_1.ship == cell_4.ship).to eq(false)
      expect(cell_2.ship == cell_4.ship).to eq(false)
      expect(cell_3.ship == cell_4.ship).to eq(false)
    end
  end

  # Iteration 2 - Overlapping Ships
  describe 'overlapping ships' do
    it 'checks valid_placement? against overlapping ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(submarine, %w[A1 B1])).to eq(false)
    end

    it 'returns true for non-overlapping ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      destroyer = Ship.new('Destroyer', 2)
      board.place(cruiser, %w[A1 A2 A3])

      expect(board.valid_placement?(destroyer, %w[B3 B4])).to be true
    end

    it 'returns false for overlapping ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      destroyer = Ship.new('Destroyer', 2)
      board.place(cruiser, %w[A1 A2 A3])

      expect(board.valid_placement?(destroyer, %w[A1 A2])).to be false
    end

    it 'returns false for diagonal ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      destroyer = Ship.new('Destroyer', 2)
      board.place(cruiser, %w[A1 A2 A3])

      expect(board.valid_placement?(destroyer, %w[A1 B2])).to be false
    end

    it 'returns false for non-consecutive ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      destroyer = Ship.new('Destroyer', 2)
      board.place(cruiser, %w[A1 A2 A3])

      expect(board.valid_placement?(destroyer, %w[A1 A4])).to be false
    end
  end

  describe 'render method' do
    it 'renders board on one line' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end
    it 'renders board on multiple lines' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])
      board_string = board.render
      expected_lines = [
        '  1 2 3 4 ',
        'A . . . . ',
        'B . . . . ',
        'C . . . . ',
        'D . . . . ',
        ''
      ]
      board_string.split("\n").each_with_index do |line, index|
        expect(line).to eq(expected_lines[index])
      end
    end
  end
end
