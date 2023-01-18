# frozen_string_literal: true

# * Class for creating a board
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def display_board
    create_column_number
    rows_for_display
  end

  private

  def create_board
    [
      Array.new(7),
      Array.new(7),
      Array.new(7),
      Array.new(7),
      Array.new(7),
      Array.new(7)
    ]
  end

  def create_column_number
    7.times do |num|
      print "\e[32m\e[1m  #{num + 1}  \e2\e[0m"
    end
    puts ''
  end

  def rows_for_display
    display_transform = lambda do |item|
      item.nil? ? '[   ]' : "[ #{item} ]"
    end

    rows = board.map do |row|
      row.map(&display_transform).join
    end
    puts rows.join("\n")
  end
end
