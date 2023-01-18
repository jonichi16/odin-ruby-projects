# frozen_string_literal: true

require './lib/connect_four'

describe ConnectFour do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

    context 'when player input is between arguments and edge case' do
      it 'stop loops and does not return an error message' do
        allow(game_input).to receive(:gets).and_return('2')
        err_msg = 'Invalid Input! Please choose between column 1 and column 7'
        expect(game_input).not_to receive(:puts).with(err_msg)
        game_input.player_input
      end

      it 'stop loops and does not return an error message' do
        allow(game_input).to receive(:gets).and_return('7')
        err_msg = 'Invalid Input! Please choose between column 1 and column 7'
        expect(game_input).not_to receive(:puts).with(err_msg)
        game_input.player_input
      end
    end

    context 'when player input is invalid once, then a valid input' do
      before do
        letter = 'a'
        valid_input = '1'
        allow(game_input).to receive(:gets).and_return(letter, valid_input)
      end

      it 'return an error message once' do
        err_msg = 'Invalid Input! Please choose between column 1 and column 7'
        expect(game_input).to receive(:puts).with(err_msg).once
        game_input.player_input
      end
    end

    context 'when player input is invalid twice, then a valid input' do
      before do
        letter = 'a'
        symbol = '@'
        valid_input = '1'
        allow(game_input).to receive(:gets).and_return(letter, symbol, valid_input)
      end

      it 'return an error message twice' do
        err_msg = 'Invalid Input! Please choose between column 1 and column 7'
        expect(game_input).to receive(:puts).with(err_msg).twice
        game_input.player_input
      end
    end
  end

  # describe '#turn_order' do
  #   let(:player_one) { double('player_1') }
  #   let(:player_two) { double('player_2') }
  #   subject(:game_turn_order) { described_class.new }

  #   context 'when the game is not over' do
  #     before do
  #       allow(game_turn_order).to receive(game_over?).and_return(false, false, false, true)
  #     end

  #     xit 'switch the current player' do
  #       expect(game).to receive(:current_player_switch).exactly(3).times
  #       game_turn_order.turn_order
  #     end
  #   end
  # end
end
