# This module allows the application to immediately exit if the word exit is entered on any user input.
module InputHelper
  def get_user_input
    input = gets.chomp.upcase
    exit if input == 'EXIT'
    input
  end
end
