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
end

# *This will create the game instance
class Game
  include TicTacToe
  attr_accessor :player1, :player2, :current_player

  def initialize
    welcome
    p self.player1 = create_player('Player1', 'X')
    p self.current_player = player1
    p self.player2 = create_player('Player2', 'O')
  end

  def start
    # method body
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

Game.new
