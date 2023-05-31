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


end