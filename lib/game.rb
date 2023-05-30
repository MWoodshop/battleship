require './lib/board'

class Game
  def initialize
    @board = Board.new
    # @player = Player.new
  end

  def start
    puts '=== Welcome to Battleship ==='
    puts 'Instructions: ...' # Provide game instructions

    setup_ships
    play_game
  end

  private

  def setup_ships
    # Prompt the user to place their ships on the board
    puts 'Please place your ships on the board...'
    # Your logic for ship placement goes here
  end

  def play_game
    puts 'Let the game begin!'

    loop do
      # Display the board and other game information
      @board.display
      # Prompt the user for their next move
      puts 'Please enter your move...'
      move = gets.chomp.upcase
      # Process the move and update the game state
      break if game_over?
      break if move == 'EXIT'
    end

    display_game_result
  end

  def game_over?
    # Determines if the game is over
    # Should be a boolean
  end

  def display_game_result
    puts 'Game Over!'
    puts 'The result is...'
    # Have the result here
  end
end
