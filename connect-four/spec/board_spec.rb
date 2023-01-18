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
end
