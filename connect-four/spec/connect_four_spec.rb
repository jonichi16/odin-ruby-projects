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

  describe '#verify_input' do
    subject(:game_verify) { described_class.new }

    context 'when player input is valid' do
      it 'returns player input' do
        input = 3
        verified = game_verify.verify_input(input)
        expect(verified).to eq(3)
      end
    end

    context 'when player input is invalid' do
      it 'returns nil' do
        input = 8
        verified = game_verify.verify_input(input)
        expect(verified).to be_nil
      end
    end
  end
end
