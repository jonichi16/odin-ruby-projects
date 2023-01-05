# frozen_string_literal: true

require './lib/words'

# *Class for creating the game
class Game
  include SelectableWords
  attr_accessor :word

  def initialize
    self.word = select_word
  end

  def select_word
    WORDS[rand(0...WORDS.length)]
  end
end

hangman = Game.new
puts hangman.word
