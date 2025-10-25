# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#player_input' do
    subject(:game_input) { described_class.new }

    let(:error_message) { 'Input error! Please enter a number from 1 to 7:' }
    let(:input_valid) { '4' }
    let(:input_word) { 'four' }
    let(:input_char) { '$' }

    context 'when user provides valid input' do
      before do
        allow(game_input).to receive(:puts)
        allow(game_input).to receive(:gets).and_return(input_valid)
      end

      it 'stops loop and does not display error message' do
        game_input.player_input
        expect(game_input).not_to have_received(:puts).with(error_message)
      end
    end

    context 'when user provides invalid input once, followed by valid input' do
      before do
        allow(game_input).to receive(:puts)
        allow(game_input).to receive(:gets).and_return(input_word, input_valid)
      end

      it 'complete loop and displays error message once' do
        game_input.player_input
        expect(game_input).to have_received(:puts).with(error_message).once
      end
    end

    context 'when user provides invalid input twice, followed by valid input' do
      before do
        allow(game_input).to receive(:puts)
        allow(game_input).to receive(:gets).and_return(input_word, input_char, input_valid)
      end

      it 'complete loop and displays error message twice' do
        game_input.player_input
        expect(game_input).to have_received(:puts).with(error_message).twice
      end
    end
  end

  describe '#process_input' do
    subject(:game_verify) { described_class.new }

    context 'when the user input is valid' do
      let(:input_valid) { '2' }

      it 'returns the number minus one' do
        processed_input = game_verify.process_input(input_valid)
        expect(processed_input).to be(1)
      end
    end

    context 'when the user input is out of range' do
      let(:input_out_of_range) { '9' }

      it 'returns nil' do
        processed_input = game_verify.process_input(input_out_of_range)
        expect(processed_input).to be_nil
      end
    end

    context 'when the user input is not a number' do
      let(:input_not_a_number) { 'three' }

      it 'returns nil' do
        processed_input = game_verify.process_input(input_not_a_number)
        expect(processed_input).to be_nil
      end
    end
  end

  describe '#win_state' do
    let(:last_move_coordinates) { [3, 4] }

    let(:board_win) { instance_double(Board, win?: true) }
    let(:board_no_win) { instance_double(Board, win?: false, full?: false) }
    let(:board_tie) { instance_double(Board, win?: false, full?: true) }

    context 'when the last move results in a win' do
      subject(:game_win) { described_class.new }

      before do
        game_win.instance_variable_set(:@prev_move, last_move_coordinates)
        game_win.instance_variable_set(:@board, board_win)
      end

      it 'calls Board#win? with previous coordinates' do
        game_win.win_state
        expect(board_win).to have_received(:win?).with(last_move_coordinates)
      end

      it 'returns :win' do
        state = game_win.win_state
        expect(state).to be(:win)
      end
    end

    context 'when the last move does not result in a win' do
      subject(:game_no_win) { described_class.new }

      before do
        game_no_win.instance_variable_set(:@prev_move, last_move_coordinates)
        game_no_win.instance_variable_set(:@board, board_no_win)
      end

      it 'calls Board#win? with previous coordinates' do
        game_no_win.win_state
        expect(board_no_win).to have_received(:win?).with(last_move_coordinates)
      end

      it 'returns nil' do
        state = game_no_win.win_state
        expect(state).to be_nil
      end
    end

    context 'when the last move results in a tie' do
      subject(:game_tie) { described_class.new }

      before do
        game_tie.instance_variable_set(:@prev_move, last_move_coordinates)
        game_tie.instance_variable_set(:@board, board_tie)
      end

      it 'calls Board#win? with previous coordinates' do
        game_tie.win_state
        expect(board_tie).to have_received(:win?).with(last_move_coordinates)
      end

      it 'calls Board#full?' do
        game_tie.win_state
        expect(board_tie).to have_received(:full?)
      end

      it 'returns :tie' do
        state = game_tie.win_state
        expect(state).to be(:tie)
      end
    end
  end
end
