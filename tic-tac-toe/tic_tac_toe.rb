# frozen_string_literal: true

WIN_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

# *Class for the game logic
class Game
  attr_accessor :player1, :player2, :current_player, :board, :current_move, :has_win

  def initialize
    welcome
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @current_move = 0
    @has_win = false
    self.player1 = create_player('Player1', 'X')
    self.current_player = player1
    self.player2 = create_player('Player2', 'O')
  end

  def welcome
    puts "\t+==============================+"
    puts "\t|==  Welcome to Tic Tac Toe  ==|"
    puts "\t+==============================+\n\n\n"
  end

  def create_player(player, character)
    puts "What's #{player}'s name?"
    Player.new(gets.chomp, character)
  end

  def display_board(board)
    puts "\t #{board[0]} | #{board[1]} | #{board[2]} "
    puts "\t---+---+---"
    puts "\t #{board[3]} | #{board[4]} | #{board[5]} "
    puts "\t---+---+---"
    puts "\t #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def start
    display_board(board)
    until has_win
      move(current_player)
      player_switch if legal_move
    end
  end

  def player_switch
    if current_player == player1
      self.current_player = player2
    elsif current_player == player2
      self.current_player = player1
    end
  end

  def move(player)
    puts "What's #{player.name}'s move?"
    self.current_move = gets.to_i
    place_move(current_move, player)
    player.player_move << current_move
    player_win(player)
  end

  def place_move(position, player)
    board[position - 1] = player.character
    display_board(board)
  end

  def legal_move
    player1.player_move.none?(current_move) || player2.player_move.none?(current_move)
  end

  def player_win(player)
    WIN_CONDITION.each do |array|
      next unless player.player_move.include?(array[0]) &&
                  player.player_move.include?(array[1]) &&
                  player.player_move.include?(array[2])

      self.has_win = true
      puts "#{player.name} WON!"
    end
  end
end

# *Class for creating player
class Player
  attr_accessor :name, :character, :player_move

  def initialize(name, character)
    self.name = name
    self.character = character
    self.player_move = []
  end
end

tictactoe = Game.new
tictactoe.start
