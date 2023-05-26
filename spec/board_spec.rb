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
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
      # expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
      # expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end
end
