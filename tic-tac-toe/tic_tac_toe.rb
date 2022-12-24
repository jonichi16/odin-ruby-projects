# frozen_string_literal: true

# *This is the module for the TicTacToe game
module TicTacToe
  WIN_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def welcome
    puts "\t+==============================+"
    puts "\t|==  Welcome to Tic Tac Toe  ==|"
    puts "\t+==============================+\n\n\n"
  end

  def create_player(player, character)
    puts "What's #{player}'s name?"
    Player.new(gets.chomp, character)
  end

  def board
    [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def display_board(board)
    board.each_with_index do |row, i|
      puts "\t #{row[0]} | #{row[1]} | #{row[2]} "
      puts "\t---+---+---" unless i == 2
    end
  end
end

# *This will create the game instance
class Game
  include TicTacToe
  attr_accessor :player1, :player2, :current_player

  def initialize
    welcome
    self.player1 = create_player('Player1', 'X')
    self.current_player = player1
    self.player2 = create_player('Player2', 'O')
  end

  def start
    display_board(board)
  end

  def player_switch
    if current_player == player1
      self.current_player = player2
    elsif current_player == player2
      self.current_player = player1
    end
  end
end

# *This will create the player instance
class Player
  attr_accessor :name, :character

  def initialize(name, character)
    self.name = name
    self.character = character
  end
end

tictactoe = Game.new
tictactoe.start
p tictactoe.current_player.name
tictactoe.player_switch
p tictactoe.current_player.name
tictactoe.player_switch
p tictactoe.current_player.name
