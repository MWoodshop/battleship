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
    end
  end
end
