require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
    it "#exists" do
        game = Game.new

        expect(game).to be_an_instance_of(Game)
    end

    it "has a board for both computer and player" do
        game = Game.new

        expect(game.computer_board).to be_an_instance_of(Board)
        expect(game.player_board).to be_an_instance_of(Board)
    end

    it "creates player and computer ships" do
        game = Game.new

        expect(game.player_cruiser).to be_an_instance_of(Ship)
        expect(game.player_sub).to be_an_instance_of(Ship)
        expect(game.computer_cruiser).to be_an_instance_of(Ship)
        expect(game.computer_sub).to be_an_instance_of(Ship)
    end

    it "places the player cruiser on valid coordinates" do
        game = Game.new
        allow(game).to receive(:gets).and_return('A1', 'A2', 'A3')
        game.player_place_cruiser

        expect(game.player_board.cells['A1'].ship).to eq(game.player_cruiser)
        expect(game.player_board.cells['A2'].ship).to eq(game.player_cruiser)
        expect(game.player_board.cells['A3'].ship).to eq(game.player_cruiser)
    end

    it "places the player sub on valid coordinates" do
        game = Game.new
        allow(game).to receive(:gets).and_return('B1', 'B2')
        game.player_place_sub

        expect(game.player_board.cells['B1'].ship).to eq(game.player_sub)
        expect(game.player_board.cells['B2'].ship).to eq(game.player_sub)
    end

    it "the computer places a ship on valid coordinates" do
        game = Game.new
        ship = Ship.new('Cruiser', 3)
        placement = game.random_ship_placement(ship)
        expect(game.computer_board.valid_placement?(ship, placement)).to be true
    end

    it "returns nil if no valid placement is available" do
        game = Game.new
        ship = Ship.new('Cruiser', 3)
        allow(game.computer_board).to receive(:valid_placement?).and_return(false)
        placement = game.random_ship_placement(ship)
        expect(placement).to be_nil
    end

    it "returns true for a valid coordinate on the board that has not been fired upon" do
        game = Game.new
        board = game.player_board
        coordinate = 'A1'
        expect(game.valid_shot?(coordinate, board)).to be true
    end

    it 'returns false for a coordinate outside the board' do
        game = Game.new
        board = game.player_board
        coordinate = 'Z10'
        expect(game.valid_shot?(coordinate, board)).to be false
    end

    it 'returns false for a coordinate on the board that has already been fired upon' do
        game = Game.new
        board = game.player_board
        coordinate = 'A1'
        board.cells[coordinate].fire_upon
        expect(game.valid_shot?(coordinate, board)).to be false
    end
end