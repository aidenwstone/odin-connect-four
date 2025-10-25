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
end
