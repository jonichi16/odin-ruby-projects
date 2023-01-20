# frozen_string_literal: true

require './lib/connect_four'

describe ConnectFour do
  describe 'player one as the current player' do
    subject(:game_init) { described_class.new }

    it 'it sets player one as current player' do
      current_player = game_init.current_player.name
      expect(current_player).to eq('Player One')
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }

    context 'when player input is between arguments and edge case' do
      it 'stop loops and does not return an error message' do
        allow(game_input).to receive(:gets).and_return('2')
        err_msg = "\n\e[31mInvalid Input!\e[0m Please choose between column 1 and column 7"
        expect(game_input).not_to receive(:puts).with(err_msg)
        game_input.player_input
      end

      it 'stop loops and does not return an error message' do
        allow(game_input).to receive(:gets).and_return('7')
        err_msg = "\n\e[31mInvalid Input!\e[0m Please choose between column 1 and column 7"
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
        err_msg = "\n\e[31mInvalid Input!\e[0m Please choose between column 1 and column 7"
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
        err_msg = "\n\e[31mInvalid Input!\e[0m Please choose between column 1 and column 7"
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

  describe '#update_board' do
    subject(:game_update) { described_class.new(board_update) }
    let(:board_update) { double('board') }

    before do
      allow(game_update).to receive(:puts)
      allow(game_update).to receive(:player_input).and_return(4)
      allow(board_update).to receive(:display_board)
    end

    it 'send a message to board to update the column' do
      expect(board_update).to receive(:update_column).with(3, "\u{1F7E1}")
      game_update.update_board
    end
  end

  describe '#player_switch' do
    subject(:game_switch) { described_class.new }

    context 'when the current player is player 1' do
      before do
        game_switch.player_switch
      end

      it 'switch current player from player 1 to player 2' do
        player_two = game_switch.player_two
        current_player = game_switch.current_player
        expect(current_player).to be(player_two)
      end
    end

    context 'when the current player is player 2' do
      before do
        game_switch.player_switch
        game_switch.player_switch
      end

      it 'switch current player from player 2 to player 1' do
        player_one = game_switch.player_one
        current_player = game_switch.current_player
        expect(current_player).to be(player_one)
      end
    end
  end
end
