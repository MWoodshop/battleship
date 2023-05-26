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
  end
end
