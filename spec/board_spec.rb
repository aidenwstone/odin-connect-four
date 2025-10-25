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

  describe '#win?' do
    context 'when there is a horizontal win' do
      subject(:board_win_horizontal) { described_class.new(win_state_horizontal) }

      let(:win_state_horizontal) do
        [
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, :red, :red, :red, :red, nil, nil]
        ]
      end

      it 'returns true' do
        expect(board_win_horizontal.win?([5, 2])).to be(true)
      end
    end

    context 'when there is a vertical win' do
      subject(:board_win_vertical) { described_class.new(win_state_vertical) }

      let(:win_state_vertical) do
        [
          [nil, nil, nil, nil, nil,  nil, nil],
          [nil, nil, nil, nil, :red, nil, nil],
          [nil, nil, nil, nil, :red, nil, nil],
          [nil, nil, nil, nil, :red, nil, nil],
          [nil, nil, nil, nil, :red, nil, nil],
          [nil, nil, nil, nil, :red, nil, nil]
        ]
      end

      it 'returns true' do
        expect(board_win_vertical.win?([3, 4])).to be(true)
      end
    end

    context 'when there is a forward diagonal win' do
      subject(:board_win_forward_diagonal) { described_class.new(win_state_forward_diagonal) }

      let(:win_state_forward_diagonal) do
        [
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, nil,  nil,  nil,  nil,  nil, nil],
          [nil, :red, nil,  nil,  nil,  nil, nil],
          [nil, nil,  :red, nil,  nil,  nil, nil],
          [nil, nil,  nil,  :red, nil,  nil, nil],
          [nil, nil,  nil,  nil,  :red, nil, nil]
        ]
      end

      it 'returns true' do
        expect(board_win_forward_diagonal.win?([4, 3])).to be(true)
      end
    end

    context 'when there is a backward diagonal win' do
      subject(:board_win_backward_diagonal) { described_class.new(win_state_backward_diagonal) }

      let(:win_state_backward_diagonal) do
        [
          [nil, nil,   nil,   nil,   nil,   nil, nil],
          [nil, nil,   nil,   nil,   :red,  nil, nil],
          [nil, nil,   nil,   :red,  nil,   nil, nil],
          [nil, nil,   :red,  nil,   nil,   nil, nil],
          [nil, :red,  nil,   nil,   nil,   nil, nil],
          [nil, nil,   nil,   nil,   nil,   nil, nil]
        ]
      end

      it 'returns true' do
        expect(board_win_backward_diagonal.win?([3, 2])).to be(true)
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      subject(:board_full) { described_class.new(full_state) }

      let(:full_state) do
        [
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red]
        ]
      end

      it 'returns true' do
        expect(board_full).to be_full
      end
    end

    context 'when the board is not full' do
      subject(:board_empty) { described_class.new }

      it 'returns false' do
        expect(board_empty).not_to be_full
      end
    end
  end
end
