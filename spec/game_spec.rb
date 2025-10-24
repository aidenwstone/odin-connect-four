# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
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
