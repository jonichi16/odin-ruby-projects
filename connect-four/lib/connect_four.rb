# frozen_string_literal: true

require './lib/board'

# * Class for the main game
class ConnectFour
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def play_game
    introduction
    turn_order
  end

  def turn_order
    # TODO: looping method that will:
    # TODO:  1. Display the current board
    # TODO:  2. Get current player input
    # TODO:  3. Switch the current player
  end

  def player_input
    loop do
      user_input = gets.chomp
      verified = verify_input(user_input.to_i) if user_input.match?(/^\d$/)
      return verified if verified

      puts 'Invalid Input! Please choose between column 1 and column 7'
    end
  end

  def verify_input(input)
    return input if input.between?(1, 7)
  end

  private

  def introduction
    puts <<~HEREDOC

      \e[32m\e[1m#{'Welcome to Connect Four'.center(50, ' ')}\e2\e[0m

      Each player takes turns in dropping a colored tokens
      into the grid by choosing the number of column.

      The tokens fall straight down, occupying the lowest
      available space within the column.

      First player to form horizontal, vertical, or
      diagonal line of four of one's own token wins.

      \e[32m\e[1mLET'S START!\e2\e[0m

    HEREDOC
  end
end
