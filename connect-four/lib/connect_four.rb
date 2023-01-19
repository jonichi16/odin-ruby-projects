# frozen_string_literal: true

require './lib/board'
require './lib/player'

# * Class for the main game
class ConnectFour
  attr_reader :board, :player_one, :player_two, :current_player

  def initialize(board = Board.new)
    @board = board
    @player_one = Player.new('Player One', "\u{1F7E1}")
    @player_two = Player.new('Player Two', "\u{1F534}")
    @current_player = player_one
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
    board.display_board
    update_board
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

  def update_board
    puts "#{current_player.name} please choose to number of column your want to play"
    column_number = player_input
    board.update_column(column_number - 1, current_player.token)
    board.display_board
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
