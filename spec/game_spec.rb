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
end