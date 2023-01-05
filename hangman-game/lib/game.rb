# frozen_string_literal: true

require './lib/words'

# *Class for creating the game
class Game
  include SelectableWords
  attr_accessor :word, :wordline, :remaining_guess, :used_letters

  def initialize
    self.word = select_word
    self.wordline = create_wordline
    self.remaining_guess = 5
    self.used_letters = []
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
    display_game if action
  end

  def display_game
    puts "\n\n"
    puts ' HANGMAN '.center(50, '=')
    puts "Remaining guess: #{remaining_guess}"
    puts "Used letter: #{used_letters}\n\n"
    display_wordline
  end

  def display_wordline
    puts wordline.join(' ')
  end
end

game = Game.new
game.start
