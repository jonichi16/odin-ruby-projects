# frozen_string_literal: true

require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board) { described_class.new }

    it 'create a board with 6 length' do
      length = board.board.length
      expect(length).to eq(6)
    end

    it 'should have empty array for values' do
      current_board = board.board
      current_board.each do |arr|
        expect(arr).to all(be_nil)
      end
    end

    it 'should have each array have 7 items' do
      current_board = board.board
      current_board.each do |arr|
        expect(arr.length).to be(7)
      end
    end
  end

  describe '#update_column' do
    subject(:board_update) { described_class.new }

    context 'when the board is empty' do
      before do
        column = 4
        token = 'token 1'
        board_update.update_column(column, token)
      end

      it 'place the token to the bottom of the column' do
        bottom = board_update.board[0][4]
        token = 'token 1'
        expect(bottom).to eq(token)
      end
    end

    context 'when one slot in the board is occupied' do
      before do
        board_update.board[0][2] = 'token 1'
        column = 4
        token = 'token 2'
        board_update.update_column(column, token)
      end

      it 'place the next token on the same row' do
        previous = board_update.board[0][2]
        current = board_update.board[0][4]
        token_one = 'token 1'
        token_two = 'token 2'
        expect(previous).to eq(token_one)
        expect(current).to eq(token_two)
      end
    end

    context 'when the bottom row of the column is occupied' do
      before do
        board_update.board[0][4] = 'token 1'
        column = 4
        token = 'token 2'
        board_update.update_column(column, token)
      end

      it 'place the next token on top of the previous token' do
        previous = board_update.board[0][4]
        current = board_update.board[1][4]
        token_one = 'token 1'
        token_two = 'token 2'
        expect(previous).to eq(token_one)
        expect(current).to eq(token_two)
      end
    end
  end

  describe '#horizontal_line' do
    subject(:game_horizontal) { described_class.new }

    context 'when one player form a horizontal line' do
      before do
        game_horizontal.board[1][3] = 'token 1'
        game_horizontal.board[1][4] = 'token 1'
        game_horizontal.board[1][5] = 'token 1'
        game_horizontal.board[1][6] = 'token 1'
      end

      it 'returns true' do
        token = 'token 1'
        row = 1
        col = 3
        result = game_horizontal.horizontal_line(row, col, token)
        expect(result).to be true
      end
    end

    context 'when one player did not form a horizontal line' do
      before do
        game_horizontal.board[0][2] = 'token 1'
        game_horizontal.board[0][4] = 'token 1'
        game_horizontal.board[0][5] = 'token 1'
        game_horizontal.board[0][6] = 'token 1'
      end

      it 'returns false' do
        token = 'token 1'
        row = 0
        col = 3
        result = game_horizontal.horizontal_line(row, col, token)
        expect(result).not_to be true
      end
    end
  end

  describe '#vertical_line' do
    subject(:game_vertical) { described_class.new }

    context 'when one player form a vertical line' do
      before do
        game_vertical.board[1][6] = 'token 1'
        game_vertical.board[2][6] = 'token 1'
        game_vertical.board[3][6] = 'token 1'
        game_vertical.board[4][6] = 'token 1'
      end

      it 'returns true' do
        token = 'token 1'
        row = 1
        col = 6
        result = game_vertical.vertical_line(row, col, token)
        expect(result).to be true
      end
    end

    context 'when one player did not form a vertical line' do
      before do
        game_vertical.board[1][2] = 'token 1'
        game_vertical.board[2][2] = 'token 1'
        game_vertical.board[3][2] = 'token 1'
        game_vertical.board[5][2] = 'token 1'
      end

      it 'returns false' do
        token = 'token 1'
        row = 1
        col = 2
        result = game_vertical.vertical_line(row, col, token)
        expect(result).not_to be true
      end
    end
  end

  describe '#right_diagonal' do
    subject(:game_right) { described_class.new }

    context 'when one player form a right diagonal line' do
      before do
        game_right.board[1][2] = 'token 1'
        game_right.board[2][3] = 'token 1'
        game_right.board[3][4] = 'token 1'
        game_right.board[4][5] = 'token 1'
      end

      it 'returns true' do
        token = 'token 1'
        row = 1
        col = 2
        result = game_right.right_diagonal(row, col, token)
        expect(result).to be true
      end
    end

    context 'when one player did not form a right diagonal line' do
      before do
        game_right.board[1][2] = 'token 1'
        game_right.board[2][3] = 'token 1'
        game_right.board[3][4] = 'token 1'
        game_right.board[5][5] = 'token 1'
      end

      it 'returns false' do
        token = 'token 1'
        row = 1
        col = 2
        result = game_right.right_diagonal(row, col, token)
        expect(result).not_to be true
      end
    end
  end

  describe '#left_diagonal' do
    subject(:game_left) { described_class.new }

    context 'when one player form a left diagonal line' do
      before do
        game_left.board[1][4] = 'token 1'
        game_left.board[2][3] = 'token 1'
        game_left.board[3][2] = 'token 1'
        game_left.board[4][1] = 'token 1'
      end

      it 'returns true' do
        token = 'token 1'
        row = 1
        col = 4
        result = game_left.left_diagonal(row, col, token)
        expect(result).to be true
      end
    end

    context 'when one player did not form a left diagonal line' do
      before do
        game_left.board[1][4] = 'token 1'
        game_left.board[2][3] = 'token 1'
        game_left.board[3][2] = 'token 1'
        game_left.board[4][0] = 'token 1'
      end

      it 'returns false' do
        token = 'token 1'
        row = 1
        col = 4
        result = game_left.left_diagonal(row, col, token)
        expect(result).not_to be true
      end
    end
  end

  describe '#check_board' do
    subject(:game_board_check) { described_class.new }

    context 'when there is a horizontal winning condition' do
      before do
        game_board_check.board[1][3] = 'token 1'
        game_board_check.board[1][4] = 'token 1'
        game_board_check.board[1][5] = 'token 1'
        game_board_check.board[1][6] = 'token 1'
        token = 'token 1'
        game_board_check.game_check(token)
      end

      it 'set the game to finish' do
        result = game_board_check.board_finish
        expect(result).to be true
      end
    end

    context 'when there is a veritcal winning condition' do
      before do
        game_board_check.board[1][6] = 'token 1'
        game_board_check.board[2][6] = 'token 1'
        game_board_check.board[3][6] = 'token 1'
        game_board_check.board[4][6] = 'token 1'
        token = 'token 1'
        game_board_check.game_check(token)
      end

      it 'set the game to finish' do
        result = game_board_check.board_finish
        expect(result).to be true
      end
    end

    context 'when there is a right diagonal winning condition' do
      before do
        game_board_check.board[1][2] = 'token 1'
        game_board_check.board[2][3] = 'token 1'
        game_board_check.board[3][4] = 'token 1'
        game_board_check.board[4][5] = 'token 1'
        token = 'token 1'
        game_board_check.game_check(token)
      end

      it 'set the game to finish' do
        result = game_board_check.board_finish
        expect(result).to be true
      end
    end

    context 'when there is a left diagonal winning condition' do
      before do
        game_board_check.board[1][4] = 'token 1'
        game_board_check.board[2][3] = 'token 1'
        game_board_check.board[3][2] = 'token 1'
        game_board_check.board[4][1] = 'token 1'
        token = 'token 1'
        game_board_check.game_check(token)
      end

      it 'set the game to finish' do
        result = game_board_check.board_finish
        expect(result).to be true
      end
    end

    context 'when there is no winning condition' do
      before do
        game_board_check.board[0][4] = 'token 1'
        game_board_check.board[2][3] = 'token 1'
        game_board_check.board[3][2] = 'token 1'
        game_board_check.board[4][1] = 'token 1'
        token = 'token 1'
        game_board_check.game_check(token)
      end

      it 'set the game to continue' do
        result = game_board_check.board_finish
        expect(result).not_to be true
      end
    end
  end
end
