# frozen_string_literal: true

require './lib/words'

# *Class for creating the game
class Game
  include SelectableWords
  attr_accessor :word, :wordline, :remaining_guess, :used_letters, :all_used_letters

  def initialize
    self.word = select_word
    self.wordline = create_wordline
    self.remaining_guess = 5
    self.used_letters = []
    self.all_used_letters = []
  end

  def select_word
    WORDS[rand(0...WORDS.length)]
  end

  def create_wordline
    Array.new(word.length).map { '_' }
  end

  def start
    puts File.read('rules.txt')
    action = gets.chomp
    player_guess if action
    game_result
  end

  def display_game
    puts "\n\n"
    puts ' HANGMAN '.center(50, '=')
    puts "Remaining guess: #{remaining_guess}"
    puts "Used letter: #{used_letters}\n\n"
    puts wordline.join(' ')
  end

  def player_guess
    until gameover
      display_game
      print "\nEnter your guess:"
      guess = gets.chomp.downcase
      if valid_guess(guess)
        puts "\nInvalid guess. Try Again"
      else
        check_guess(guess)
      end
    end
  end

  def check_guess(guess)
    if word.include?(guess)
      word.split('').each_with_index do |char, i|
        wordline[i] = guess if char == guess
      end
      all_used_letters.push(guess)
    else
      used_letters.push(guess)
      all_used_letters.push(guess)
      self.remaining_guess -= 1
    end
  end

  def game_result
    display_game
    if word == wordline.join('')
      puts 'You WON!'
    else
      puts "You LOSE! The word is #{word}"
    end
  end

  def gameover
    remaining_guess.zero? || word == wordline.join('')
  end

  def valid_guess(guess)
    guess.length > 1 || guess.match?(/[^a-z]/) || all_used_letters.include?(guess)
  end
end

game = Game.new
game.start
