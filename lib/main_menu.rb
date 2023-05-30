require './lib/game'
require './lib/ascii'

class MainMenu
  include Ascii
  def initialize
    @game = Game.new
  end

  def display_main_menu
    Ascii.display_art
    puts '=== Main Menu ==='
    puts 'Press P to play'
    puts 'Press Q to quit'
  end

  # Main menu loop
  def start
    loop do
      display_main_menu
      print 'Please enter a command: '
      choice = gets.chomp.downcase

      case choice
      when 'p', 'P'
        puts 'Starting the game...'
        @game.start
      when 'q', 'Q', 'exit'
        puts 'Quitting the application...'
        puts "\n"
        break
      else
        puts 'Invalid choice. Please try again.'
      end

      puts "\n"
    end
  end
end

menu = MainMenu.new
menu.start
