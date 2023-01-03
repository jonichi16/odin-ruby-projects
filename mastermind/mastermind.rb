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
    puts "\t X - one out of four of your guess has the correct number and correct position"
    puts "\t O - one out of four of your guess has the correct number but wrong position"
    puts '4) Code Maker earns 1 point for every incorrect guess and 3 points'
    puts "  if you did not cracked the code with 12 guesses\n\n"
  end

  def welcome
    puts "\t+=============================+"
    puts "\t|==  Welcome to Mastermind  ==|"
    puts "\t+=============================+\n"
    # puts 'Please choose your role?'
    # puts "1 - Code Maker\t2 - Code Breaker"
    # self.player_role = gets.to_i
  end
end

# *Class for the game logic
class Game
  include Rules
  attr_accessor :player, :computer, :turns, :code_cracked

  def initialize
    self.code_cracked = false
    self.turns = 12
    welcome
    display_rules
    create_player
    start
  end

  def create_player
    self.player = Player.new
    self.computer = Computer.new
  end

  def start
    play
    puts "\nCongrats! You've cracked the code! The code is #{computer.code}" if code_cracked
    puts "Sorry! You've run out of turns.The code is #{computer.code} Try Again" if turns.zero? && code_cracked == false
  end

  def play
    p computer.code
    until code_cracked || turns.zero?
      puts "Turns remaining: #{turns}"
      guessing
      self.turns -= 1
      win?
    end
  end

  def guessing
    player.guess
    computer.check_guess(player.player_guess)
    computer.display_response
  end

  def win?
    if computer.response.all?('X')
      self.code_cracked = true
    else
      player.player_choice = ''
      computer.response = []
    end
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
      if num == code[i]
        response.push('X')
        next
      elsif code.none?(num)
        response.push(' ')
      elsif code.include?(num)
        next if guess.slice(0, i).include?(num)

        response.push('O')
      end
    end
  end

  def display_response
    sorted_response = response.sort.reverse
    puts "\nCode Maker Response"
    puts " #{sorted_response[0]} | #{sorted_response[1]} "
    puts '---+---'
    puts " #{sorted_response[2]} | #{sorted_response[3]}"
  end
end

Game.new
