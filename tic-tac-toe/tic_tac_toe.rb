# frozen_string_literal: true

# * This will contain board maker
module Board
  WIN_CONDITIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

  def create_board(player1, player2)
    puts "\t 1 | 2 | 3 \t\tScoreboards:"
    puts "\t---+---+---"
    puts "\t 4 | 5 | 6 \t\t#{player1.name} (#{player1.character}) Score: #{player1.score}"
    puts "\t---+---+---"
    puts "\t 7 | 8 | 9 \t\t#{player2.name} (#{player2.character}) Score: #{player2.score}"
  end

  def create_players(num, players)
    player = Player.new(num, players)
    unique_character(player) unless players[0].nil?
    add_player(player)
  end

  def unique_character(player)
    while players[0].character == player.character
      puts "#{player.character} is already taken. Please choose another"
      player.character = gets.chomp
    end
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
    (1..2).each { |num| create_players(num, players) }
    puts "\n\n"
    create_board(players[0], players[1])
  end
end

# * This will create a player
class Player
  include Board
  attr_accessor :name, :character, :score, :player_move

  def initialize(num, players)
    puts "What is player #{num}'s name?"
    self.name = gets.chomp
    puts "What is #{name}'s character?"
    puts "(#{players[0].character}) is already taken" if num == 2
    self.character = character_check
    self.score = 0
    self.player_move = []
  end

  def character_check
    character = gets.chomp
    until character.match?(/^\w$/)
      puts "\nInvalid Character. Please use one character only"
      puts "What is #{name}'s character?"
      character = gets.chomp
    end
    character
  end
end

tictactoe = Game.new
tictactoe.game_start
