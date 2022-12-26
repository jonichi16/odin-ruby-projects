# frozen_string_literal: true

# *Utility module
module Rules
  def display_rules
    code_breaker_rules
  end

  def code_breaker_rules
    puts "\n\nCode Breaker Rules: Guess the code set by the Code Maker within 12 guesses"
    puts ''
    puts '1) Code Maker will set a 4 digit code from 1 - 6 (can be duplicate e.g. 1122, 1145)'
    puts '2) Input the 4 digit number of your guess'
    puts '3) Code Maker will give a response based on your guess'
    puts "\t O - one out of four of your guess has the correct number and correct position"
    puts "\t X - one out of four of your guess has the correct number but wrong position"
    puts '4) Code Maker earns 1 point for every incorrect guess and 3 points'
    puts "  if you did not cracked the code with 12 guesses\n\n"
  end

  def welcome
    puts "\t+=============================+"
    puts "\t|==  Welcome to Mastermind  ==|"
    puts "\t+=============================+\n\n\n"
    # puts 'Please choose your role?'
    # puts "1 - Code Maker\t2 - Code Breaker"
    # self.player_role = gets.to_i
  end
end

# *Class for the game logic
class Game
  include Rules
  attr_accessor :player, :computer, :turns

  def initialize
    welcome
    display_rules
    create_player
    start
  end

  def create_player
    self.turns = 12
    self.player = Player.new
    self.computer = Computer.new
  end

  def start
    player.guess
    p player.player_choice
    p computer.code
  end
end

# *Class for creating players
class Player
  attr_accessor :player_choice

  def initialize
    self.player_choice = []
  end

  def guess
    puts "You're the Code Breaker! What is your guess?"
    guess = gets.chomp.split('')
    guess.each { |num| player_choice.push(num.to_i) }
  end
end

# *Class for the computer
class Computer
  attr_accessor :code

  def initialize
    self.code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end
end

Game.new
