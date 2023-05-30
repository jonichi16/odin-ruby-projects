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
    turn_order until game_over?
    final_message
  end

  def turn_order
    update_board
    board.game_check(current_player.token)
    player_switch unless game_over?
  end

  def player_input
    loop do
      user_input = gets.chomp
      verified = verify_input(user_input.to_i) if user_input.match?(/^\d$/)
      return verified if verified && !board.full_column(user_input.to_i - 1) 

      puts "\n\e[31mInvalid Input!\e[0m Please choose between column 1 and column 7"
      puts "\e[31mColumn #{user_input} is already full\e[0m" if board.full_column(user_input.to_i - 1)
    end
  end

  def verify_input(input)
    return input if input.between?(1, 7)
  end

  def update_board
    puts "\n#{current_player.name} please choose between column 1 and column 7"
    column_number = player_input
    board.update_column(column_number - 1, current_player.token)
    print "\e[2J\e[f"
    board.display_board
  end

  def player_switch
    @current_player = current_player == player_one ? player_two : player_one
  end

  def game_over?
    board.board_finish
  end

  private

  # rubocop:disable Metrics/MethodLength
  def introduction
    print "\e[2J\e[f"
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

    board.display_board
  end
  # rubocop:enable Metrics/MethodLength

  def final_message
    puts ''
    puts " \e[32mCongratulations! #{current_player.name} won!\e[0m ".center(50, '*')
    puts ''
  end
end
