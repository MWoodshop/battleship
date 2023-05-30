require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

class Game
  attr_reader :player_board,
              :computer_board,
              :computer_cruiser,
              :computer_sub,
              :player_cruiser,
              :player_sub

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_sub = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_sub = Ship.new('Submarine', 2)
  end

  def start
    puts '=== Welcome to Battleship ==='
    puts 'Instructions: ...' # Provide game instructions
    player_place_cruiser
    player_place_sub
    computer_cruiser_coords
  end

  # !!! Add valid coordinate check !!!

  def player_place_cruiser
    # Prompt the user to place their ships on the board
    puts 'Please place your ships on the board...'
    # Your logic for ship placement goes here
    puts 'The Cruiser is 3 units long.'
    puts 'Please place the first Cruiser coordinate (ex. A1, A2, B1, B2).'
    input1 = gets.chomp.upcase
    puts 'Please place the second Cruiser coordinate (ex. A1, A2, B1, B2).'
    input2 = gets.chomp.upcase
    puts 'Please place the third Cruiser coordinate (ex. A1, A2, B1, B2).'
    input3 = gets.chomp.upcase
    player_cruiser_coords = [input1, input2, input3]
    @player_board.place(@player_cruiser, player_cruiser_coords)
    puts ''
    rendered_board = @player_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    puts ''
  end

  def player_place_sub
    # Prompt the user to place their ships on the board
    puts 'Please place your ships on the board...'
    # Your logic for ship placement goes here
    puts 'The Submarine is 2 units long.'
    puts 'Please place the first Submarine coordinate (ex. A1, A2, B1, B2).'
    input1 = gets.chomp.upcase
    puts 'Please place the second Submarine coordinate (ex. A1, A2, B1, B2).'
    input2 = gets.chomp.upcase
    player_sub_coords = [input1, input2]
    @player_board.place(@player_sub, player_sub_coords)
    puts ''
    rendered_board = @player_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    puts ''
  end

  def computer_cruiser_coords
    letter_array = @computer_board.cells.keys
    coord_array = []

    until @computer_board.valid_placement?(@computer_sub, coord_array)
      coord_array.clear

      3.times do
        coord_array << letter_array.sample
      end
    end

    @computer_cruiser_coords = cord_array
  end

  def play_game
    puts 'Let the game begin!'
    # loop do
    #   # Display the board and other game information
    #   puts @board.render
    #   # Prompt the user for their next move
    #   puts 'Please enter your move...'
    #   move = gets.chomp.upcase
    #   # Process the move and update the game state
    #   break if game_over?
    #   break if move == 'EXIT'
    # end

    display_game_result
  end

  def game_over?
    false
    # Determines if the game is over
    # Should be a boolean
  end

  def display_game_result
    puts 'Game Over!'
    puts 'The result is...'
    # Have the result here
  end
end
