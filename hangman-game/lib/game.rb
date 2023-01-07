# frozen_string_literal: true

require './lib/words'
require 'yaml'

# *Class for creating the game and game logic
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
    player_guess
    game_result if gameover
  end

  def display_game
    puts "\n\n"
    puts ' HANGMAN '.center(50, '=')
    puts "Remaining guess: #{remaining_guess}"
    puts "Used letter: #{used_letters}\n\n"
    puts wordline.join(' ')
  end

  def player_guess
    loop do
      display_game
      print "\nType 'save' to save the game and exit\nEnter your guess:"
      guess = gets.chomp.downcase
      player_save if guess == 'save'
      play(guess)
      break if exit_game(guess)
    end
  end

  def exit_game(guess)
    gameover || guess == 'save'
  end

  def play(guess)
    if valid_guess(guess) && guess != 'save'
      puts "\nInvalid guess. Try Again"
    else
      check_guess(guess)
    end
  end

  def check_guess(guess)
    all_used_letters.push(guess)
    if word.include?(guess)
      word.split('').each_with_index do |char, i|
        wordline[i] = guess if char == guess
      end
    else
      used_letters.push(guess)
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

  def save_game(fname)
    if File.exist? "./saved/#{fname}.yaml"
      puts 'Filename already exist. Please choose other name'
      player_save
    else
      File.open("./saved/#{fname}.yaml", 'w') { |file| file.puts YAML.dump(self) }
    end
  end

  def player_save
    Dir.mkdir 'saved' unless Dir.exist? 'saved'
    print 'Enter filename:'
    fname = gets.chomp.downcase
    save_game(fname)
  end
end
