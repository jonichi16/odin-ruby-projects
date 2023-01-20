# frozen_string_literal: true

# * Class for creating a board
class Board
  attr_reader :board, :board_finish

  def initialize
    @board = create_board
    @board_finish = false
  end

  def display_board
    puts ''
    create_column_number
    rows_for_display
  end

  def update_column(column, token)
    board.each do |row|
      next if row[column]

      row[column] = token
      break
    end
  end

  def horizontal_line(row, col, token)
    return if col > 3

    board[row][col] == token &&
      board[row][col + 1] == token &&
      board[row][col + 2] == token &&
      board[row][col + 3] == token
  end

  def vertical_line(row, col, token)
    return if row > 2

    board[row][col] == token &&
      board[row + 1][col] == token &&
      board[row + 2][col] == token &&
      board[row + 3][col] == token
  end

  def right_diagonal(row, col, token)
    return if row > 2 || col > 3

    board[row][col] == token &&
      board[row + 1][col + 1] == token &&
      board[row + 2][col + 2] == token &&
      board[row + 3][col + 3] == token
  end

  def left_diagonal(row, col, token)
    return if row > 2 || col < 3

    board[row][col] == token &&
      board[row + 1][col - 1] == token &&
      board[row + 2][col - 2] == token &&
      board[row + 3][col - 3] == token
  end

  def game_check(token)
    board.each_with_index do |row, r|
      row.each_index do |c|
        @board_finish = true if horizontal_line(r, c, token) ||
                                vertical_line(r, c, token) ||
                                right_diagonal(r, c, token) ||
                                left_diagonal(r, c, token)
      end
    end
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
      print "\e[32m\e[1m   #{num + 1}  \e2\e[0m"
    end
    puts ''
  end

  def rows_for_display
    display_transform = lambda do |item|
      item.nil? ? '[    ]' : "[ #{item} ]"
    end

    rows = board.reverse.map do |row|
      row.map(&display_transform).join
    end
    puts rows.join("\n")
  end
end

# board = Board.new
# puts board.display_board
# board.update_column(4, '0')
# puts board.display_board
# board.update_column(4, '1')
# puts board.display_board
# board.update_column(3, '0')
# puts board.display_board
