# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#drop_token' do
    subject(:board_drop) { described_class.new }

    let(:player_token) { :red }
    let(:column_index) { 2 }

    context 'when the column is empty' do
      it 'places token on lowest row' do
        board_drop.drop_token(player_token, column_index)
        token = board_drop.grid[5][column_index]
        expect(token).to eq(player_token)
      end

      it 'returns the coordinates' do
        coordinates = board_drop.drop_token(player_token, column_index)
        expect(coordinates).to eq([5, column_index])
      end
    end

    context 'when the column is not empty' do
      before do
        board_drop.drop_token(:yellow, column_index)
      end

      it 'places token above last token' do
        board_drop.drop_token(player_token, column_index)
        token = board_drop.grid[4][column_index]
        expect(token).to eq(player_token)
      end

      it 'returns the coordinates' do
        coordinates = board_drop.drop_token(player_token, column_index)
        expect(coordinates).to eq([4, column_index])
      end
    end

    context 'when the column is full' do
      before do
        6.times { board_drop.drop_token(:yellow, column_index) }
      end

      it 'does not modify the board' do
        expect { board_drop.drop_token(player_token, column_index) }.not_to(change(board_drop, :grid))
      end

      it 'returns nil' do
        result = board_drop.drop_token(player_token, column_index)
        expect(result).to be_nil
      end
    end
  end
end
