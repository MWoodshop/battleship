require './lib/game'
require './lib/ascii'

class MainMenu
  include Ascii

  def initialize
    @game = Game.new
  end

  def display_main_menu
    puts '=== Main Menu ==='
    puts 'Press P to play'
    puts 'Press I for instructions'
    puts 'Press Q to quit'
    puts ''
  end

  # Main menu loop
  def start
    Ascii.display_art
    loop do
      display_main_menu
      print 'Please enter a command: '
      choice = gets.chomp.downcase

      case choice
      when 'p'
        puts 'Starting the game...'
        @game.start
      when 'i'
        game_instructions
      when 'q'
        quit_application
        break
      else
        puts 'Invalid choice. Please try again.'
      end

      puts "\n"
    end
  end

  def quit_application
    puts 'Quitting the application...'
    puts "\n"
    exit(0) # Exit the application with a status code of 0
  end
end

def game_instructions
  puts ''
  puts '=== Instructions ==='
  # Provide game instructions
  puts 'Instructions: You will play against the super advanced Turing 6100 Super Computer'
  puts 'First you will place your Cruiser ship which has a length of 3'
  puts 'Next you will place your Submarine ship which has a length of 2.'
  puts 'The board is in a grid in the following format:'
  puts '    A   B   C   D'
  puts  '1 |.| |.| |.| |.|'
  puts  '2 |.| |.| |.| |.|'
  puts  '3 |.| |.| |.| |.|'
  puts  '4 |.| |.| |.| |.|'
  puts ''
  puts 'Once you place your pieces the computer will do the same.'
  puts 'You will then take turns firing upon coordinates until all ships on either side are sunk.'
  puts 'A ship has health equal to its length.'
  puts 'All ships can only be placed within the grid and either horizontally or vertically.'
  puts ''

  print 'Press any key to return to the main menu or Q to quit: '
  choice = gets.chomp.downcase
  return unless choice == 'q'

  quit_application
end

menu = MainMenu.new
menu.start
