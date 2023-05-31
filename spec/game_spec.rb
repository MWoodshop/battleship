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

    

end