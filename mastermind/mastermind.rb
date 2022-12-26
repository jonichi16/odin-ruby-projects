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
    computer.check_guess(player.player_guess)
    p computer.code
    p player.player_guess
    p computer.response.sort.reverse
  end
end

# *Class for creating players
class Player
  attr_accessor :player_choice

  def initialize
    self.player_choice = ''
  end

  def guess
    until legal_move
      puts "You're the Code Breaker! What is your guess?"
      self.player_choice = gets.chomp
      puts 'INVALID GUESS! Please try again' unless legal_move
    end
  end

  def player_guess
    player_choice.split('').map(&:to_i)
  end

  def legal_move
    player_choice.match?(/^[1-6]{4}$/)
  end
end

# *Class for the computer
class Computer
  attr_accessor :code, :response

  def initialize
    self.code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    self.response = []
  end

  def check_guess(guess)
    guess.each_with_index do |num, i|
      if code[i] == num
        response.push('O')
      elsif code.one?(num)
        response.push('X')
      else
        response.push(' ')
      end
    end
  end
end

Game.new
