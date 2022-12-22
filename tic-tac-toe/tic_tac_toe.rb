# frozen_string_literal: true

# * This will contain board maker
module Board
  win_condition = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  def create_board(player1, player2)
    puts "\t 1 | 2 | 3 \t\tScores:"
    puts "\t---+---+---"
    puts "\t 4 | 5 | 6 \t\t#{player1.name} Score: #{player1.score}"
    puts "\t---+---+---"
    puts "\t 7 | 8 | 9 \t\t#{player2.name} Score: #{player2.score}"
  end

  def create_players(num)
    puts "What is player #{num}'s name?"
    player_name = gets.chomp
    puts "What is #{player_name}'s character?"
    player_character = gets.chomp
    player = Player.new(player_name, player_character)
    add_player(player)
  end
end

# * This will create the Tic Tac Toe Game
class Game
  include Board
  attr_reader :players

  def initialize
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def welcome
    puts "\t+==============================+"
    puts "\t|==  Welcome to Tic Tac Toe  ==|"
    puts "\t+==============================+\n\n\n"
  end

  def game_start
    welcome
    (1..2).each { |num| create_players(num) }
    puts "\n\n"
    create_board(players[0], players[1])
  end
end

# * This will create a player
class Player
  include Board
  attr_accessor :name, :character, :score

  def initialize(name, character)
    self.name = name
    self.character = character
    self.score = 0
  end
end

tictactoe = Game.new
tictactoe.game_start
