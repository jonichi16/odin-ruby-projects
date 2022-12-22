# frozen_string_literal: true

# * This will contain board maker
module Board
  WIN_CONDITIONS = [
    %w[1 2 3],
    %w[4 5 6],
    %w[7 8 9],
    %w[1 4 7],
    %w[2 5 8],
    %w[3 6 9],
    %w[1 5 9],
    %w[3 5 7]
  ].freeze

  def board
    @board = {}
    (1..9).each do |num|
      @board[num.to_s] = num.to_s
    end
    @board
    # @board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
  end

  def edit_board(position, character)
    @board[position] = character
    create_board(@board)
  end

  def create_board(board)
    puts "\t #{board['1']} | #{board['2']} | #{board['3']} "
    puts "\t---+---+---"
    puts "\t #{board['4']} | #{board['5']} | #{board['6']} "
    puts "\t---+---+---"
    puts "\t #{board['7']} | #{board['8']} | #{board['9']} "
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
  attr_reader :players, :is_win, :turn

  @is_win = false
  @turn = 1

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
    create_board(board)
    play
  end

  def play
    until @is_win
      players.each do |player|
        break if @is_win

        puts "What's #{player.name} move?"
        move = gets.chomp
        edit_board(move, player.character)
        player.player_move << move
        win(player.player_move)
      end
    end
  end

  def win(move)
    return unless move.length >= 3

    puts 'Draw! Try Again.' if @is_win == false && @turn == 9

    combination = move[-3..]
    @is_win = WIN_CONDITIONS.include?(combination.sort)
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
