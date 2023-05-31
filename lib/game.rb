require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/input_helper'
require 'pry'

class Game
  attr_reader :player_board,
              :computer_board,
              :computer_cruiser,
              :computer_sub,
              :player_cruiser,
              :player_sub

  # Use this format on any chomp to allow exit to escape: input = get_user_input
  include InputHelper

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_cruiser = Ship.new('Cruiser', 3)
    @computer_sub = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_sub = Ship.new('Submarine', 2)
  end

  def start
    puts ''
    puts '=== Welcome to Battleship! ==='
    puts ''
    setup_game
  end

  def setup_game
    player_place_cruiser
    player_place_sub
    computer_place_cruiser
    # Debug Only Start - Comment Out when shipped to Prod
    puts 'Computer Board:'
    rendered_board = @computer_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    # Debug Only End - Comment Out when shipped to Prod
    computer_place_sub
    # Debug Only Start - Comment Out when shipped to Prod
    puts 'Computer Board:'
    rendered_board = @computer_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    # Debug Only End - Comment Out when shipped to Prod
    play_game
  end

  def play_game
    until @player_cruiser.sunk? == true && @player_sub.sunk? == true || @computer_cruiser.sunk? == true && @computer_sub.sunk? == true
      player_shot
      computer_shot
      if @player_cruiser.sunk? == true && @player_sub.sunk? == true
        puts 'I won!'
      elsif @computer_cruiser.sunk? == true && @computer_sub.sunk? == true
        puts 'You won!'
      end
    end
  end

  def player_shot
    puts 'Enter the coordinate for your shot:'
    print '> '
    player_shot_coordinate = get_user_input
    until @computer_board.valid_coordinate?(player_shot_coordinate) == true && @computer_board.cells[player_shot_coordinate].fired_upon? == false
      puts 'Please enter a valid coordinate:'
      print '> '
      player_shot_coordinate = get_user_input
    end
    @computer_board.cells[player_shot_coordinate].fire_upon
    if @computer_board.cells[player_shot_coordinate].render == 'M'
      puts 'Your shot on ' + player_shot_coordinate + ' missed the target.'
    elsif @computer_board.cells[player_shot_coordinate].render == 'H'
      puts 'Your shot on ' + player_shot_coordinate + ' hit the target.'
    elsif @computer_board.cells[player_shot_coordinate].render == 'X'
      puts 'Your shot on ' + player_shot_coordinate + ' sunk my battleship.'
    end
    puts ''
    rendered_board = @computer_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    puts ''
  end

  def computer_shot
    computer_shot_coordinate = @player_board.cells.keys.sample
    computer_shot_coordinate = @player_board.cells.keys.sample until @player_board.cells[computer_shot_coordinate].fired_upon? == false
    @player_board.cells[computer_shot_coordinate].fire_upon
    if @player_board.cells[computer_shot_coordinate].render == 'M'
      puts 'My shot on ' + computer_shot_coordinate + ' missed the target.'
    elsif @player_board.cells[computer_shot_coordinate].render == 'H'
      puts 'My shot on ' + computer_shot_coordinate + ' hit the target.'
    elsif @player_board.cells[computer_shot_coordinate].render == 'X'
      puts 'My shot on ' + computer_shot_coordinate + ' sunk your battleship.'
    end
    puts ''
    rendered_board = @player_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    puts ''
  end

  # Setup Begin:

  def player_place_cruiser
    # Prompt the user to place their ships on the board
    puts 'Please place your ships on the board...'
    puts 'The Cruiser is 3 units long.'
    puts 'Please place the first Cruiser coordinate (ex. A1, A2, B1, B2).'
    input1 = get_user_input
    puts 'Please place the second Cruiser coordinate (ex. A1, A2, B1, B2).'
    input2 = get_user_input
    puts 'Please place the third Cruiser coordinate (ex. A1, A2, B1, B2).'
    input3 = get_user_input
    player_cruiser_coords = [input1, input2, input3]
    until @player_board.valid_placement?(@player_cruiser, player_cruiser_coords) == true
      puts 'Those are invalid coordinates! Please try again:'
      puts ''
      print '> '
      player_cruiser_coords.clear
      input1 = get_user_input
      print '> '
      input2 = get_user_input
      print '> '
      input3 = get_user_input
      player_cruiser_coords = [input1, input2, input3]
    end
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
    input1 = get_user_input
    puts 'Please place the second Submarine coordinate (ex. A1, A2, B1, B2).'
    input2 = get_user_input
    player_sub_coords = [input1, input2]
    until @player_board.valid_placement?(@player_sub, player_sub_coords) == true
      puts 'Those are invalid coordinates! Please try again:'
      puts ''
      print '> '
      player_sub_coords.clear
      input1 = get_user_input
      print '> '
      input2 = get_user_input
      player_sub_coords = [input1, input2]
    end
    @player_board.place(@player_sub, player_sub_coords)
    puts ''
    rendered_board = @player_board.render(true)
    rendered_board.split("\n").each do |line|
      puts line
    end
    puts ''
  end

  def random_ship_placement(ship)
    possible_placements = []
    @computer_board.cells.keys.each do |coordinate|
      (0...ship.length).each do |_i|
        horizontal_placement = (0...ship.length).map { |j| coordinate[0] + (coordinate[1..-1].to_i + j).to_s }
        vertical_placement = (0...ship.length).map { |j| (coordinate[0].ord + j).chr + coordinate[1..-1] }
        possible_placements << horizontal_placement if @computer_board.valid_placement?(ship, horizontal_placement)
        possible_placements << vertical_placement if @computer_board.valid_placement?(ship, vertical_placement)
      end
    end
    possible_placements.sample
  end

  def computer_place_cruiser
    @computer_cruiser_coords = random_ship_placement(@computer_cruiser)
    @computer_board.place(@computer_cruiser, @computer_cruiser_coords)
  end

  def computer_place_sub
    @computer_sub_coords = random_ship_placement(@computer_sub)
    @computer_board.place(@computer_sub, @computer_sub_coords)
  end

  def computer_cruiser_coords
    coord_array = random_ship_placement(@computer_cruiser)
    @computer_board.place(@computer_cruiser, coord_array)
  end

  def computer_sub_coords
    coord_array = random_ship_placement(@computer_sub)
    @computer_board.place(@computer_sub, coord_array)
  end

  # Setup End

  def turn
    player_turn
    return if game_over?

    computer_turn
  end

  def player_turn
    puts 'Enter the coordinate for your shot:'
    input = get_user_input

    until valid_shot?(input, @computer_board)
      puts 'Please enter a valid coordinate:'
      input = get_user_input
    end

    cell = @computer_board.cells[input]
    cells.fire_upon
    print_shot_result(input, cell, 'Player')
  end

  def computer_turn
    input = @player_board.cells.keys.sample

    input = @player_board.cells.keys.sample until valid_shot?(input, @player_board)

    cell = @player_board.cells[input]
    cell.fire_upon
    print_shot_result(input, cell, 'Computer')
  end

  def valid_shot?(coordinate, board)
    board.valid_coordinate?(coordinate) && !board.cells[coordinate].fired_upon?
  end

  def print_shot_result(coordinate, cell, shooter)
    result = if cell.empty? || cell.ship.nil?
               'miss'
             elsif cell.ship.sunk?
               'sunk'
             else
               'hit'
             end

    puts "#{shooter} shot on #{coordinate} was a #{result}."
  end

  def game_over?
    [@player_board, @computer_board].any? do |board|
      board.cells.values.all? { |cell| cell.empty? || (cell.ship && cell.ship.sunk?) }
    end
  end

  def display_game_result
    if @player_board.cells.values.all? { |cell| cell.empty? || (cell.ship && cell.ship.sunk?) }
      puts 'Turing 6100 won the game!'
    else
      puts 'Player won the game!'
    end
  end
end
