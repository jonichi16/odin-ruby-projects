# frozen_string_literal: true

require 'yaml'
require './lib/game'

# *This will manage the game
class Manager
  def self.run
    puts File.read('rules.txt')
    print 'Select: '
    choice = gets.chomp
    game_choice(choice)
  end

  def self.game_choice(choice)
    case choice
    when '1'
      hangman = Game.new
      hangman.start
    when '2'
      load
    end
  end

  def self.load
    if empty?
      empty_savefile
    else
      puts "\nSelect saved file:\n\n"
      Dir.glob('./saved/*.yaml').each_with_index { |file, i| puts "#{i + 1}: #{file.to_s[8..-6]}" }
      print "\nEnter the number of your file: "
      file = gets.chomp.to_i
      load_game(file)
    end
  end

  def self.load_game(file)
    filename = Dir.glob('./saved/*.yaml')[file - 1]
    game = YAML.load_file(
      filename,
      permitted_classes: [Game]
    )
    game.start
  end

  def self.empty?
    !Dir.exist?('saved') || Dir.glob('./saved/*').length.zero?
  end

  def self.empty_savefile
    puts ''
    puts ' No save file available '.center(50, '*')
    print "\nEnter any key to go back"
    gets.chomp
    run
  end
end
