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
end
